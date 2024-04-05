// import { SolanaConnect } from "solana-connect";
// import { Adapter } from "@solana/wallet-adapter-base";
import {AnchorProvider, BN, Program, setProvider, web3} from "@project-serum/anchor";
import {Connection, Keypair, PublicKey, TransactionMessage} from "@solana/web3.js";
import {TOKEN_PROGRAM_ID} from "@project-serum/anchor/dist/cjs/utils/token";
import idl from './abi/abi.json'
import { Buffer } from 'buffer';
import {
    createAssociatedTokenAccountInstruction,
    createInitializeMintInstruction,
    getAssociatedTokenAddress, getAssociatedTokenAddressSync,
    MINT_SIZE
} from "@solana/spl-token";
import { create } from 'ipfs-http-client'
import * as splToken from "@solana/spl-token";
import * as anchor from "@project-serum/anchor";
import bs58 from "bs58";
import NodeWallet from "@project-serum/anchor/dist/cjs/nodewallet";
import {randomBytes} from "ethers/lib/utils";
import axios from "axios";

const solConnect = new window.SolanaConnect();
var walletOr = '';
var pub = '';
var TOKEN_METADATA_PROGRAM_ID = new PublicKey( "metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s");
const connection = new Connection("https://api.devnet.solana.com");
const PROGRAM_ID = new PublicKey( "D5GK8Kye78gjuDMMjRnkWH5a6KfNEXzex5mekXL3HLR2");
let provider = new AnchorProvider(connection, solConnect.getWallet(), { commitment: "confirmed" })
let program = new Program(idl, PROGRAM_ID, provider);

async function getMetadata(mint) {
    return (await web3.PublicKey.findProgramAddress(
        [
            Buffer.from("metadata"),
            TOKEN_METADATA_PROGRAM_ID.toBuffer(),
            mint.toBuffer(),
        ],
        TOKEN_METADATA_PROGRAM_ID
    ))[0];
};

$('.connect_wallet').click(function () {
    solConnect.openMenu({
        top: 100
    });

    solConnect.onWalletChange((adapter) => {
        walletOr = adapter.publicKey.toString();
        pub = adapter;
        $('.connect_wallet').hide()
        $('.mint_nft').show();
        $('.mint_number').show();
        $('.mint-image').show();
        // $('.nft-image').show();
        provider = new AnchorProvider(connection, adapter, { commitment: "confirmed" })
        program = new Program(idl, PROGRAM_ID, provider);
        setProvider(provider)
    });
})

$('.page-content').on("click", ".mint_nft", async function () {
    const type = $(this).val();
    const { blockhash, lastValidBlockHeight } =
        await connection.getLatestBlockhash('confirmed');
    let mintNumber = $(this).parent().parent().find('.mint_number').val();
    var ownerWallet = new PublicKey(walletOr);
    const classAppend = $(this).parent().parent().next();
    if (mintNumber == undefined || mintNumber < 0) {
        mintNumber = 1;
    }

    let txs = [];
    var mintAccount = [];
    var deposits = [];
    var seeds = [];
    var names = [];
    var symbols = [];
    var uris = [];
    var pools = [];

    for (let i = 0; i < mintNumber; i++) {
        txs.push(await createNftTx(blockhash, ownerWallet, lastValidBlockHeight, mintAccount, names, symbols, uris))
    }

    $('.loading').show();

    const signedTxs = await pub.signAllTransactions(txs);
    for (const signedTx in signedTxs) {
        console.log(signedTxs);

        signedTxs[signedTx].partialSign(mintAccount[signedTx]);
        console.log(mintAccount);
        const signature = await connection.sendRawTransaction(
            signedTxs[signedTx].serialize(),
            {
                skipPreflight: true,
                preflightCommitment: 'confirmed',
                maxRetries: 50,
            }
        );
        console.log(blockhash);
        await connection.confirmTransaction(
            {
                blockhash,
                lastValidBlockHeight,
                signature,
            },
            'confirmed'
        );

        deposits.push(await addToPool(mintAccount[signedTx], ownerWallet, blockhash, seeds, pools));
    }

    const signedDepositTxs = await pub.signAllTransactions(deposits);

    for (const signedTx of signedDepositTxs) {
        const signature = await connection.sendRawTransaction(
            signedTx.serialize(),
            {
                skipPreflight: true,
                preflightCommitment: 'confirmed',
                maxRetries: 50,
            }
        );
    }

    // append
    for (const index in names) {
        const classNe = $('.nft-div-append');
        if (type == 2) classNe
        appendValueNft(names[index], symbols[index], uris[index], seeds[index], pools[index],
            mintAccount[index].publicKey.toString(), provider.wallet.publicKey.toString(), classAppend, type)
    }

    alert('Mint NFT is success. Please see on https://explorer.solana.com/')
    $(this).parent().next().find('#mint-sol').attr('href', 'https://explorer.solana.com/address/'+ provider.wallet.publicKey.toString() +'=devnet')
    $(this).parent().next().find('#mint-sol').show();
    $(this).text('Minted');
    $('.loading').hide();

    // try {
    //     const eventId = $('#eventIdHidden').val();
    //     const body = {
    //         name,
    //         symbol,
    //         uri,
    //         seed: seed + '',
    //         pool,
    //         address_nft: mintKeypair.publicKey.toString(),
    //         address_organizer: provider.wallet.publicKey.toString(),
    //         secret_key: mintKeypair.secret_key,
    //         type,
    //         task_id: eventId
    //     }
    //     console.log(body);
    //
    //     const res = await axios.post("/create-nft-claim", body);
    //     alert('Mint NFT is success. Please see on https://explorer.solana.com/')
    //     $(this).parent().next().find('#mint-sol').attr('href', 'https://explorer.solana.com/address/'+ provider.wallet.publicKey.toString() +'=devnet')
    //     $(this).parent().next().find('#mint-sol').show();
    //     $(this).text('Minted');
    //     $('.loading').hide();
    // } catch (error) {
    //     throw new Error(error.message)
    // }
})

function appendValueNft(name, symbol, uri, seed, pool, addressNft, secret, classAppend, type) {
    let classA = '';
    if (type == 2) classA = 'session';
    if (type == 3) classA = 'booth';
    classAppend.append('<input type="hidden" name="nft-ticket-name-'+classA+'[]" value="'+name+'"/>')
    classAppend.append('<input type="hidden" name="nft-ticket-symbol-'+classA+'[]" value="'+symbol+'"/>')
    classAppend.append('<input type="hidden" name="nft-ticket-uri-'+classA+'[]" value="'+uri+'"/>')
    classAppend.append('<input type="hidden" name="nft-ticket-seed-'+classA+'[]" value="'+seed+'"/>')
    classAppend.append('<input type="hidden" name="nft-ticket-pool-'+classA+'[]" value="'+pool+'"/>')
    classAppend.append('<input type="hidden" name="nft-ticket-address-nft-'+classA+'[]" value="'+addressNft+'"/>')
    classAppend.append('<input type="hidden" name="nft-ticket-secret-key-'+classA+'[]" value="'+secret+'"/>')
    classAppend.append('<input type="hidden" name="nft-ticket-address-organizer-'+classA+'[]" value="'+provider.wallet.publicKey.toString()+'"/>')
}

async function addToPool(mintNftKey, ownerWallet, blockhash, seeds, pools) {
    const seed = new BN(randomBytes(8));
    seeds.push(seed);
    const nftPrice = 0;
    console.log(`seed: ${seed}`);
    const nftTokenAccount = await getAssociatedTokenAddress(
        mintNftKey.publicKey,
        provider.wallet.publicKey
    );
    const pool = web3.PublicKey.findProgramAddressSync(
        [
            Buffer.from("state"),
            seed.toArrayLike(Buffer, "le", 8)
        ],
        program.programId
    )[0];

    pools.push(pool);

    const poolTokenAddress = await getAssociatedTokenAddressSync(
        mintNftKey.publicKey,
        pool,
        true
    );
    //
    const depositTx = await program.methods
        .deposit(seed, new BN(nftPrice))
        .accounts(
            {
                mint: mintNftKey.publicKey,
                tokenAccount: nftTokenAccount,
                mintAuthority: ownerWallet,
                pool: pool,
                poolTokenAccount: poolTokenAddress,
            }
        ).instruction();

    let tx = new web3.Transaction();
    tx.recentBlockhash = blockhash;
    tx.feePayer = ownerWallet;
    const setComputeUnitLimitInstruction = web3.ComputeBudgetProgram.setComputeUnitLimit(
        {units: 500_000}
    );
    tx.add(setComputeUnitLimitInstruction, depositTx);

    return tx;
}

async function createNftTx(blockhash, ownerWallet, lastValidBlockHeight, mintAccount, names, symbols, uris) {
    const mintKeypair = await web3.Keypair.generate();
    mintAccount.push(mintKeypair);
    const nftTokenAccount = await getAssociatedTokenAddress(
        mintKeypair.publicKey,
        provider.wallet.publicKey
    );

    console.log("Mint key: ", mintKeypair.publicKey.toString());
    console.log("User: ", provider.wallet.publicKey.toString());

    const metadataAddress = await getMetadata(mintKeypair.publicKey);
    console.log("Metadata address: ", metadataAddress);
    const masterEditionAddress = await (web3.PublicKey.findProgramAddressSync(
        [
            Buffer.from("metadata"),
            TOKEN_METADATA_PROGRAM_ID.toBuffer(),
            mintKeypair.publicKey.toBuffer(),
            Buffer.from("edition"),
        ],
        TOKEN_METADATA_PROGRAM_ID
    ))[0];

    const name = (Math.random() + 1).toString(36).substring(7);
    const symbol = 'fee';
    const uri = 'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg';

    names.push(name);
    symbols.push(symbol);
    uris.push(uri);

    const mintTx = await program.methods
        .mint(name,
            symbol,
            uri)
        .accounts(
            {
                masterEdition: masterEditionAddress,
                mintAuthority: provider.wallet.publicKey,
                mint: mintKeypair.publicKey,
                tokenAccount: nftTokenAccount,
                tokenProgram: TOKEN_PROGRAM_ID,
                metadata: metadataAddress,
                tokenMetadataProgram: TOKEN_METADATA_PROGRAM_ID,
                payer: provider.wallet.publicKey,
                systemProgram: web3.SystemProgram.programId,
            }
        ).instruction()

    let tx = await new web3.Transaction();
    tx.recentBlockhash = blockhash;
    tx.feePayer = ownerWallet;
    const setComputeUnitLimitInstruction = web3.ComputeBudgetProgram.setComputeUnitLimit(
        { units: 500_000 }
    );
    tx.add(setComputeUnitLimitInstruction, mintTx);

    return tx;
}

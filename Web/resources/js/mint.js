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
import FormData from 'form-data'

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

$('.page-content').on("click", ".submit-btn", async function () {
    // upload image
    let data = new FormData();
    let file = $('#nft_file').prop('files');
    $('.loading').show();

    data.append('file', file[0], file[0].name);

    axios.post('/upload-image-nft', data, {
        headers: {
            'accept': 'application/json',
            'Accept-Language': 'en-US,en;q=0.8',
            'Content-Type': `multipart/form-data; boundary=${data._boundary}`,
        }
    }).then((response) => {
        console.log(response.data.path);
        solConnect.openMenu({
            top: 100
        });

        solConnect.onWalletChange( async (adapter) => {
            walletOr = adapter.publicKey.toString();
            pub = adapter;
            provider = new AnchorProvider(connection, adapter, {commitment: "confirmed"})
            program = new Program(idl, PROGRAM_ID, provider);
            setProvider(provider)

            const type = $(this).val();
            const {blockhash, lastValidBlockHeight} =
                await connection.getLatestBlockhash('confirmed');
            let mintNumber = $('#nft_amount').val();
            var ownerWallet = new PublicKey(walletOr);
            const classAppend = $(this).parent().parent().next();
            if (mintNumber == undefined || mintNumber < 0) {
                mintNumber = 1;
            }

            const nftName = $('#nft_name').val();
            const nftSymbol = $('#nft_Description').val();
            const nftUri = $('#nft_file').val();

            let txs = [];
            var mintAccount = [];
            var deposits = [];
            var seeds = [];
            var names = [];
            var symbols = [];
            var uris = [];
            var pools = [];
            var types = [];

            if ($('.itemSessionDetail').length > 0) {
                await $('.itemSessionDetail').each(async function (index) {
                    let data = new FormData();
                    let file = $(this).find('.nft_file_session').prop('files');
                    data.append('file', file[0], file[0].name);

                    const response1 = await axios.post('/upload-image-nft', data, {
                        headers: {
                            'accept': 'application/json',
                            'Accept-Language': 'en-US,en;q=0.8',
                            'Content-Type': `multipart/form-data; boundary=${data._boundary}`,
                        }
                    });
                    let sessionName = $(this).find('.name_session').val();
                    let description = $(this).find('.description_session').val();
                    txs.push(await createNftTx(sessionName, description, response1.data.path, blockhash, ownerWallet, lastValidBlockHeight, mintAccount, names, symbols, uris))
                    types.push(2);
                });
            }

            if ($('.itemBoothDetail').length > 0) {
                await $('.itemBoothDetail').each(async function (index) {
                    let data = new FormData();
                    let file = $(this).find('.nft_file_booth').prop('files');
                    data.append('file', file[0], file[0].name);

                    await axios.post('/upload-image-nft', data, {
                        headers: {
                            'accept': 'application/json',
                            'Accept-Language': 'en-US,en;q=0.8',
                            'Content-Type': `multipart/form-data; boundary=${data._boundary}`,
                        }
                    }).then(async (response2) => {
                        let boothName = $(this).find('.name_booth').val();
                        let description = $(this).find('.description_booth').val();
                        txs.push(await createNftTx(boothName, description, response2.data.path, blockhash, ownerWallet, lastValidBlockHeight, mintAccount, names, symbols, uris))
                        types.push(3);
                    });
                });
            }

            for (let i = 0; i < mintNumber; i++) {
                txs.push(await createNftTx(nftName, nftSymbol, response.data.path, blockhash, ownerWallet, lastValidBlockHeight, mintAccount, names, symbols, uris))
                types.push(1);
            }

            setTimeout(async () => {
                const signedTxs = await pub.signAllTransactions(txs);
                for (const signedTx in signedTxs) {

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
                    appendValueNft(names[index], symbols[index], uris[index], seeds[index], pools[index],
                        mintAccount[index].publicKey.toString(), provider.wallet.publicKey.toString(), classNe, types[index])
                }

                alert('Mint NFT is success. Please see on https://explorer.solana.com/')
                $(this).parent().next().find('#mint-sol').attr('href', 'https://explorer.solana.com/address/' + provider.wallet.publicKey.toString() + '=devnet')
                $(this).parent().next().find('#mint-sol').show();
                $(this).text('Minted');
                $('.loading').hide();
                $('#post_form').submit();
            }, 5000);


            console.log(txs);


        });
    }).catch((error) => {
        alert(error)
    });



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

$('.mint-nft-append').click(function () {
    if (confirm("Are you sure to mint NFT Ticket") == true) {
        $('.amount-nft-ticket').text($('#nft_amount').val());
    }
})

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

async function createNftTx(nftName, nftSymbol, nftUri, blockhash, ownerWallet, lastValidBlockHeight, mintAccount, names, symbols, uris) {
    const mintKeypair = await web3.Keypair.generate();
    mintAccount.push(mintKeypair);
    const nftTokenAccount = await getAssociatedTokenAddress(
        mintKeypair.publicKey,
        provider.wallet.publicKey
    );

    console.log("Mint key: ", mintKeypair.publicKey.toString());
    console.log("User: ", provider.wallet.publicKey.toString());
    console.log("nftName: ", nftName);

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

    const name = nftName;
    const symbol = nftSymbol;
    const uri = nftUri;

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

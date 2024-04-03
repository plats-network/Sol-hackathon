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

$('.mint_nft').click(async function () {
    const type = $(this).val();
    const mintKeypair = web3.Keypair.generate();
    const ownerWallet = new PublicKey(walletOr);

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
    const uri = 'https://cms.plats.test/nft/' + name;

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

    const { blockhash, lastValidBlockHeight } =
        await connection.getLatestBlockhash('confirmed');
    let tx = new web3.Transaction();
    tx.recentBlockhash = blockhash;
    tx.feePayer = ownerWallet;
    const setComputeUnitLimitInstruction = web3.ComputeBudgetProgram.setComputeUnitLimit(
        { units: 500_000 }
    );
    tx.add(setComputeUnitLimitInstruction, mintTx);
    const signedTx = await pub.signTransaction(tx);
    signedTx.partialSign(mintKeypair);
    const signature = await connection.sendRawTransaction(
        signedTx.serialize(),
        {
            skipPreflight: true,
            preflightCommitment: 'confirmed',
            maxRetries: 50,
        }
    );

    await connection.confirmTransaction(
        {
            blockhash,
            lastValidBlockHeight,
            signature,
        },
        'confirmed'
    );

    const seed = new BN(randomBytes(8));
    const nftPrice = 0;
    console.log(`seed: ${seed}`);
    const pool = web3.PublicKey.findProgramAddressSync(
        [
            Buffer.from("state"),
            seed.toArrayLike(Buffer, "le", 8)
        ],
        program.programId
    )[0];

    const poolTokenAddress = await getAssociatedTokenAddressSync(
        mintKeypair.publicKey,
        pool,
        true
    );

    const depositTx = await program.methods
        .deposit(seed, new BN(nftPrice))
        .accounts(
            {
                mint: mintKeypair.publicKey,
                tokenAccount: nftTokenAccount,
                mintAuthority: ownerWallet,
                pool: pool,
                poolTokenAccount: poolTokenAddress,
            }
        ).instruction();

    await confirmSign(ownerWallet, depositTx, mintKeypair);

    try {
        const eventId = $('#eventIdHidden').val();
        const body = {
            name,
            symbol,
            uri,
            seed: seed + '',
            pool,
            address_nft: mintKeypair.publicKey.toString(),
            address_organizer: provider.wallet.publicKey.toString(),
            secret_key: mintKeypair.secret_key,
            type,
            task_id: eventId
        }
        console.log(body);

        const res = await axios.post("/create-nft-claim", body);
        if (res.data.status === "success") {
            alert('Mint NFT is success.')
        }
    } catch (error) {
        throw new Error(error.message)
    }
})

async function confirmSign(ownerWallet, mintTx, mintKeypair) {
    const {blockhash, lastValidBlockHeight} =
        await connection.getLatestBlockhash('confirmed');
    let tx = new web3.Transaction();
    tx.recentBlockhash = blockhash;
    tx.feePayer = ownerWallet;
    const setComputeUnitLimitInstruction = web3.ComputeBudgetProgram.setComputeUnitLimit(
        {units: 500_000}
    );
    tx.add(setComputeUnitLimitInstruction, mintTx);
    const signedTx = await pub.signTransaction(tx);
    // signedTx.partialSign(mintKeypair);
    const signature = await connection.sendRawTransaction(
        signedTx.serialize(),
        {
            skipPreflight: true,
            preflightCommitment: 'confirmed',
            maxRetries: 50,
        }
    );
}

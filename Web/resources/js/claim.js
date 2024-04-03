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
import {Magic} from "magic-sdk";

const solConnect = new window.SolanaConnect();
var walletOr = '';
var pub = '';
var TOKEN_METADATA_PROGRAM_ID = new PublicKey( "metaqbxxUerdq28cj1RbAWkYQm3ybzjb6a8bt518x1s");
const connection = new Connection(web3.clusterApiUrl("devnet"));
const PROGRAM_ID = new PublicKey( "D5GK8Kye78gjuDMMjRnkWH5a6KfNEXzex5mekXL3HLR2");
let provider = new AnchorProvider(connection, solConnect.getWallet(), { commitment: "confirmed" })
let program = new Program(idl, PROGRAM_ID, provider);
// import { Magic } from 'magic-sdk';

// let magic;

// Get your API key from dashboard.magic.link
let magic = new Magic('pk_live_7AC27AA25AE25994', { testMode: true });

$('#connect_wallet').click(async function () {
    const userAddress = $('#user_address').val();
    const userPublicKey = new web3.PublicKey(userAddress)
    const adapter = userPublicKey;
    walletOr = adapter.publicKey.toString();
    const mintKeypairId = $('#address_nft').val();
    const feeW = $('#address_organizer').val();
    const seedP = $('#seed').val();
    console.log(mintKeypairId);
    console.log(feeW)
    console.log(seedP)
    const mintKeypair = new PublicKey(mintKeypairId);
    const wallet0 = adapter

    const buyTokenAddress = await getAssociatedTokenAddress(
        mintKeypair,
        userPublicKey
    );

    const seed = new BN(seedP); // TODO: enter seed
    const pool = web3.PublicKey.findProgramAddressSync(
        [
            Buffer.from("state"),
            seed.toArrayLike(Buffer, "le", 8)
        ],
        program.programId
    )[0];

    const poolTokenAddress = await getAssociatedTokenAddressSync(
        mintKeypair,
        pool,
        true
    );

    const feeWallet = new PublicKey(feeW);

    const claimTx = await program.methods
        .claim()
        .accounts(
            {
                mint: mintKeypair,
                poolTokenAccount: poolTokenAddress,
                pool: pool,
                buyerTokenAccount: buyTokenAddress,
                buyerAuthority: userPublicKey,
                feeWallet: feeWallet,
            }
        ).instruction();

    await confirmSign(wallet0, claimTx, mintKeypair);
})

async function confirmSign(ownerWallet, mintTx, mintKeypair) {
    const {blockhash, lastValidBlockHeight} =
        await connection.getLatestBlockhash('confirmed');
    let tx = new web3.Transaction();
    tx.recentBlockhash = blockhash;
    tx.feePayer = ownerWallet.publicKey;
    const setComputeUnitLimitInstruction = web3.ComputeBudgetProgram.setComputeUnitLimit(
        {units: 500_000}
    );
    tx.add(setComputeUnitLimitInstruction, mintTx);
    const signedTransaction = await magic?.solana.signTransaction(
        tx,
        {
            requireAllSignatures: false,
            verifySignatures: true,
        }
    )

    // const signedTx = await ownerWallet.signTransaction(tx);
    const signature = await connection.sendRawTransaction(
        signedTransaction.serialize(),
        {
            skipPreflight: true,
            preflightCommitment: 'confirmed',
            maxRetries: 50,
        }
    );
}

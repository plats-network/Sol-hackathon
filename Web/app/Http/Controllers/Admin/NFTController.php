<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\NFT;
use Illuminate\Http\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Response;
use Illuminate\View\View;

class NFTController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): View
    {
        $nfts = NFT::latest()->paginate(5);

        return view('nfts.index',compact('nfts'))
            ->with('i', (request()->input('page', 1) - 1) * 5);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(): View
    {
        return view('nfts.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): RedirectResponse
    {
        $request->validate([
            'name' => 'required',
            'detail' => 'required',
        ]);

        NFT::create($request->all());

        return redirect()->route('nfts.index')
            ->with('success','NFT created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(NFT $product): View
    {
        return view('nfts.show',compact('product'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(NFT $product): View
    {
        return view('nfts.edit',compact('product'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, NFT $product): RedirectResponse
    {
        $request->validate([
            'name' => 'required',
            'detail' => 'required',
        ]);

        $product->update($request->all());

        return redirect()->route('nfts.index')
            ->with('success','NFT updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(NFT $product): RedirectResponse
    {
        $product->delete();

        return redirect()->route('nfts.index')
            ->with('success','NFT deleted successfully');
    }

    public function createNftClaim(Request $request)
    {
        $nft = new NFT\NFTMint();
        $nft->nft_title = $request->name ?? '';
        $nft->nft_symbol = $request->symbol ?? '';
        $nft->nft_uri = $request->uri ?? '';
        $nft->seed = $request->seed ?? '';
        $nft->address_nft = $request->address_nft ?? '';
        $nft->address_organizer = $request->address_organizer ?? '';
        $nft->secret_key = $request->secret_key ?? '';
        $nft->type = $request->type;
        $nft->task_id = $request->task_id;

        $nft->save();

        if ($nft) {
            return [
                'code' => 200,
                'msg' => 'success'
            ];
        }

        return null;
    }

    public function updateNftClaim(Request $request)
    {
        $nft = NFT\NFTMint::find($request->nft_id);
        $nft->status = 3;
        $nft->save();

        return [
            "code" => 200
        ];
    }

    public function uploadImageNft(Request $request)
    {
        $path = \Storage::disk('s3')->put('images/originals', $request->file, 'public');
//        $fullPath = $this->getFullPath();
//        $imageRequest = $request->file;
//        $filenameWithExt = $imageRequest->getClientOriginalName();
//        $filename = pathinfo($filenameWithExt, PATHINFO_FILENAME);
//        $extension = $imageRequest->getClientOriginalExtension();
//        $fileNameToStore = $filename.'_'.str_shuffle(time()).'.'.$extension;
//        $image = $imageRequest->storeAs($fullPath, $fileNameToStore, 's3');
        $path = $path != false ? $path : 'https://letsenhance.io/static/8f5e523ee6b2479e26ecc91b9c25261e/1015f/MainAfter.jpg';
        return [
            "code" => 200,
            'path' => $path
        ];
    }

    public function getFullPath()
    {
        /*Path Date Year*/
        $pathDateYear = date('Y');
        /*Path Date Month*/
        $pathDateMonth = date('m');
        /*Path Date Day*/
        $pathDateDay = date('d');

        return 'public/images/'.$pathDateYear.$pathDateMonth;
    }
}

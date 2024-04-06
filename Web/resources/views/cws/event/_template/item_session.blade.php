<div class="mb-3 row itemSessionDetail itemSessionDetailMint" id="itemSession{{$indexImageItem}}">
    <div class="col-4">
        <input type="file"
               accept="image/x-png, image/jpeg"
               style="display: none"
               class="image-file"
               id="image-file{{$indexImageItem}}"
               name="file-image-nft"
        />
        <label for="image-file{{$indexImageItem}}">
            <img class="image-label img-preview" src="https://static.vecteezy.com/system/resources/previews/007/567/154/original/select-image-icon-vector.jpg">
        </label>
    </div>
    <div class="col-6">
        <div class="col-10 mt-20">
            <input
                type="text"
                class="form-control name_session"
                id="sessions[detail][{{$indexImageItem}}][name]"
                name="sessions[detail][{{$indexImageItem}}][name]"
                placeholder="Name session"
                value="">
        </div>
        <div class="col-10 mt-20">
            <input
                type="text"
                class="form-control description_session"
                id="sessions[detail][{{$indexImageItem}}][description]"
                name="sessions[detail][{{$indexImageItem}}][description]"
                placeholder="Description"
                value="">
        </div>
    </div>
    <div class="col-2" style="margin-top: 50px">
        <button type="button" class="btn-delete-nft-ticket-session btn btn-danger">Delete</button>
    </div>

    {{-- And question --}}
    <div id="s-{{$indexImageItem}}" class="d-none">
        <div class="row mt-1">
            <label class="form-check-label">Question</label>
            <div class="col-sm-12">
                <input
                    type="text"
                    class="form-control"
                    id="sq-{{$indexImageItem}}"
                    name="sessions[detail][{{$indexImageItem}}][question]"
                    placeholder=""
                    value="">
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-sm-4">
                <label class="form-check-label">Answer 1</label>
                <input
                    type="text"
                    class="form-control"
                    id="sa1-{{$indexImageItem}}"
                    name="sessions[detail][{{$indexImageItem}}][a1]"
                    placeholder=""
                    value="">
            </div>
            <div class="col-sm-2 mt-4">
                <input
                    class="form-check-input"
                    data-id="{{$indexImageItem}}"
                    type="checkbox"
                    value="1"
                    name="sessions[detail][{{$indexImageItem}}][is_a1]"
                    id="is_a1_{{$getInc}}">
                <label class="form-check-label" for="is_a1_{{$getInc}}">
                    Yes/No
                </label>
            </div>
            <div class="col-sm-4">
                <label class="form-check-label">Answer 2</label>
                <input
                    type="text"
                    class="form-control"
                    id="sa2-{{$indexImageItem}}"
                    name="sessions[detail][{{$indexImageItem}}][a2]"
                    placeholder=""
                    value="">
            </div>
            <div class="col-sm-2 mt-4">
                <input
                    class="form-check-input"
                    data-id="{{$indexImageItem}}"
                    type="checkbox" value="1"
                    name="sessions[detail][{{$indexImageItem}}][is_a2]"
                    id="is_a2_{{$getInc}}">
                <label class="form-check-label" for="is_a2_{{$getInc}}">
                    Yes/No
                </label>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-sm-4">
                <label class="form-check-label">Answer 3</label>
                <input
                    type="text"
                    class="form-control"
                    id="sa3-{{$indexImageItem}}"
                    name="sessions[detail][{{$indexImageItem}}][a3]"
                    placeholder=""
                    value="">
            </div>
            <div class="col-sm-2 mt-4">
                <input
                    class="form-check-input"
                    data-id="{{$indexImageItem}}"
                    type="checkbox" value="1"
                    name="sessions[detail][{{$indexImageItem}}][is_a3]"
                    id="is_a3_{{$getInc}}">
                <label class="form-check-label" for="is_a3_{{$getInc}}">
                    Yes/No
                </label>
            </div>
            <div class="col-sm-4">
                <label class="form-check-label">Answer 4</label>
                <input
                    type="text"
                    class="form-control"
                    id="sa4-{{$indexImageItem}}"
                    name="sessions[detail][{{$indexImageItem}}][a4]"
                    placeholder="Nội dung"
                    value="">
            </div>
            <div class="col-sm-2 mt-4">
                <input
                    class="form-check-input"
                    data-id="{{$indexImageItem}}"
                    type="checkbox" value="1"
                    name="sessions[detail][{{$indexImageItem}}][is_a4]"
                    id="is_a4_{{$getInc}}">
                <label class="form-check-label" for="is_a4_{{$getInc}}">
                    Yes/No
                </label>
            </div>
        </div>
    </div>

</div>

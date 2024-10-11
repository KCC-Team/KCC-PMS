<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<ul class="list-unstyled mb-0 w-100 dropzone-preview">
    <li class="mt-2 dz-preview dz-file-preview dropzone-preview-list">
        <div class="border rounded-3">
            <div class="d-flex align-items-center p-2">
                <div class="dz-image">
                    <img data-dz-thumbnail alt="Preview" src='../../../../resources/output/images/file-icon.png' style="width: 16px"/>
                </div>
                <div class="dz-details flex-grow-1">
                    <h6 class="font-semibold mb-1 dz-filename" data-dz-name>&nbsp;</h6>
                    <p class="text-sm text-muted fw-normal dz-size" data-dz-size></p>
                    <strong class="error text-danger dz-error-message" data-dz-errormessage></strong>
                </div>
                <div class="dz-remove">
                    <button data-dz-remove class="btn btn-sm btn-danger">제거</button>
                </div>
            </div>
        </div>
    </li>
</ul>

<script>
    Dropzone.autoDiscover = false;

    function initDropzone(selector, preDiv, previewTemplate) {
        const url = "http://localhost:8085";
        return new Dropzone(selector, {
            url: url + "/post",
            method: "post",
            autoProcessQueue: false,
            previewTemplate: previewTemplate,
            previewsContainer: preDiv + ' .dropzone-preview',
        });
    }
</script>
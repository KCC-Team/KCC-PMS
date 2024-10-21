<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<ul class="list-unstyled mb-0 w-100 dropzone-preview">
    <li class="mt-2 dz-preview dz-file-preview dropzone-preview-list">
        <div class="border rounded-3">
            <div class="d-flex align-items-center p-2">
                <div class="dz-image">
                    <img data-dz-thumbnail alt="Preview" src='../../../../resources/output/images/file-icon.png' style="width: 16px"/>
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
            url: url + "/api/risk",
            method: "post",
            contentType: false,
            autoProcessQueue: false,
            previewTemplate: previewTemplate,
            previewsContainer: preDiv + ' .dropzone-preview',
        });
    }
</script>
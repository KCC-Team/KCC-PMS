<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<ul class="list-unstyled mb-0 w-100 dropzone-preview">
</ul>

<script>
    Dropzone.autoDiscover = false;

    function initDropzone(selector, preDiv, previewTemplate, path) {
        const url = "http://localhost:8085";
        return new Dropzone(selector, {
            url: url + path,
            method: "post",
            contentType: false,
            autoProcessQueue: false,
            previewTemplate: previewTemplate,
            previewsContainer: preDiv + ' .dropzone-preview',
        });
    }
</script>
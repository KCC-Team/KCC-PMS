<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<ul class="list-unstyled mb-0 w-100 dropzone-preview">
</ul>

<script>
    Dropzone.autoDiscover = false;
    function initDropzone(selector, preDiv, previewTemplate, path) {
        return new Dropzone(selector, {
            url: path,
            method: "post",
            contentType: false,
            autoProcessQueue: false,
            previewTemplate: previewTemplate,
            previewsContainer: preDiv + ' .dropzone-preview',
            acceptedFiles:
                '.jpg,.jpeg,.png,.gif,.bmp,.tiff,.svg,.webp,.' +
                'doc,.docx,.xls,.xlsx,.ppt,.pptx,.pdf,.txt,.rtf,.csv,.md,' +
                '.zip,.rar,.7z,.tar,.gz,.bz2,' +
                '.xml,.json,.psd,.ai,' +
                '.mp4,.mov,.avi,.mp3,.wav',
            dictInvalidFileType: '허용되지 않는 파일 형식입니다.',
            maxFilesize: 20,
            dictFileTooBig: '파일 크기가 너무 큽니다. 최대 파일 크기는 {{maxFilesize}}MB입니다.',
        });
    }
</script>
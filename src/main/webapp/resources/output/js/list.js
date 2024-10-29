// jstree
let selectedNodeId = null;

$(function () {
    // 노드 이동 이벤트 핸들러
    $('.jstree-files').on('move_node.jstree', function (e, data) {
        let parentNode = data.instance.get_node(data.parent);

        if (parentNode.type === 'n') {
            alert('이 노드 아래로 이동할 수 없습니다.');
            data.instance.refresh();
        } else {
            updateTreeData(data.node, data.parent);
        }
    });

    // treeData 업데이트 함수
    function updateTreeData(movedNode, newParentId) {
        let node = removeNodeById(window.treeData, parseInt(movedNode.id));

        if (newParentId === '#') {
            window.treeData.push(node);
        } else {
            let parentNode = findNodeById(window.treeData, newParentId);
            if (parentNode) {
                if (!parentNode.children) {
                    parentNode.children = [];
                }
                parentNode.children.push(node);
            }
        }
    }

    // 노드를 찾아서 제거하는 함수
    function removeNodeById(nodes, id) {
        for (let i = 0; i < nodes.length; i++) {
            if (nodes[i].id === id) {
                return nodes.splice(i, 1)[0];
            } else if (nodes[i].children) {
                let node = removeNodeById(nodes[i].children, id);
                if (node) {
                    return node;
                }
            }
        }
        return null;
    }

    // 노드를 ID로 찾는 함수
    function findNodeById(nodes, id) {
        for (let i = 0; i < nodes.length; i++) {
            if (nodes[i].id === parseInt(id)) {
                return nodes[i];
            } else if (nodes[i].children) {
                let node = findNodeById(nodes[i].children, id);
                if (node) {
                    return node;
                }
            }
        }
        return null;
    }

    // 위치 편집 버튼 클릭 이벤트
    $(".modify-btn").on("click", function () {
        // 텍스트 확인하여 상태 변경
        let isEditing = $(this).text().includes("순서 편집");
        $(this).html(
            isEditing
                ? "&nbsp;&nbsp;&nbsp;저장&nbsp;&nbsp;&nbsp;"
                : '&nbsp;&nbsp;순서 편집&nbsp;'
        );

        if (isEditing) {
            // 드래그 앤 드롭 활성화
            $('.jstree-files').jstree(true).settings.dnd.is_draggable = function () {
                return true;
            };
        } else {
            // 드래그 앤 드롭 비활성화
            $('.jstree-files').jstree(true).settings.dnd.is_draggable = function () {
                return false;
            };
            let treeData = $('.jstree-files').jstree(true).get_json('#', { flat: false });
            let updatedTreeData = transformTreeData(treeData);
            $.ajax({
                url: '/projects/outputs/api/update',
                method: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(updatedTreeData),
                success: function(response) {
                    alert('순서가 성공적으로 저장되었습니다.');
                    window.location.href = '/projects/outputs';
                },
                error: function(xhr, status, error) {
                    alert('순서 저장 중 에러가 발생했습니다.');
                }
            });
        }
    });

    $('#search').on('keypress', function (e) {
        if (e.which === 13) { // 엔터 키 코드
            let v = $(this).val();
            $('.jstree-files').jstree(true).search(v);
        }
    });

    $('#search-btn').on('click', function () {
        let v = $('#search').val();
        $('.jstree-files').jstree(true).search(v);
    });
});

let grid
$(function () {
    grid = new ax5.ui.grid();
    grid.setConfig({
        target: $('[data-ax5grid="my-grid"]'),
        showRowSelector: true,
        multipleSelect: true,
        columns: [
            {key: "fileItem", label: "파일명", width: 283.6, align: "left",
                formatter: function () {
                    return `
                            <input type="hidden" value="${this.item.fileItem.fileNo}">
                            <input type="hidden" name="filePath" value="${this.item.fileItem.filePath}">
                            <input type="hidden" name="fileTitle" value="${this.item.fileItem.fileTitle}">
                            <span>${this.item.fileItem.fileTitle}</span>
                    `;
                }
            },
            {key: "fileType", label: "파일형식", width: 80, align: "center"},
            {
                key: "fileSize",
                label: "용량",
                width: 90,
                align: "center",
                formatter: function () {
                    return formatBytes(this.value);
                }
            },
            {
                key: "registedDate",
                label: "등록일자",
                width: 100,
                align: "center",
                formatter: function () {
                    return formatDate(this.value);
                }
            },
            {key: "registedBy", label: "작성자", width: 80, align: "center"},
            {
                key: null,
                label: "작업",
                width: 100,
                align: "center",
                formatter: function () {
                    return `
                        <div class="d-flex justify-content-center">
                            <button class="ms-1 file-btn file-down-btn" data-file="${this.item.filePath}">&nbsp;다운로드&nbsp;</button>
                        </div>
                    `;
                }
            }
        ]
    });

    // grid.setData(gridData);
    // $('#detail-cnt').text(gridData.length);
    $(document).on('click', '.btn-download', function () {
        let fileName = $(this).data('file');
        // 다운로드 로직 구현
        alert(fileName + ' 다운로드 버튼 클릭됨');
    });

    $(document).on('click', '.btn-upload', function () {
        let fileName = $(this).data('file');
        // 업로드 로직 구현
        alert(fileName + ' 업로드 버튼 클릭됨');
    });

    $('.file-insert-btn').on('click', function () {
        $('#insertModal').modal('show');
    });

    $('.file-modify-btn').on('click', function () {
        $('#modifyModal').modal('show');
    });

    const $selectElement = $('#task-select-list');
    const $selectBox = $('.select-box-list');

    let selectedOptions = [];
    $selectElement.on('change', function () {
        const value = $selectElement.val();
        if (value && !selectedOptions.includes(value)) {
            selectedOptions.push(value);
            createLabel(value);
        }
        $selectElement.val('');
    });

    $('.jstree-files').on('select_node.jstree', function (e, data) {
        selectedNodeId = data.node.id;
        window.selectNode = data.node;
        $('.second-component').addClass('fade-out');
        if (data.node.type === 'n') {
            $.ajax({
                url: '/projects/outputs/' + data.node.id,
                method: 'GET',
                success: function (response) {
                    setTimeout(() => {
                        grid.setData(response.files);
                        $('#detail-cnt').text(response.files.length);
                        $('.input-area').val(response.title);

                        $('#outputTask').empty();
                        response.tasks.forEach(function(task) {
                            let $taskLink = $('<a>').attr('href', '#').addClass('task ms-4').text(task);
                            $('#outputTask').append($taskLink, '<br>');
                        });

                        $('.second-component').removeClass('fade-out').addClass('fade-in');
                        setTimeout(() => {
                            $('.second-component').removeClass('fade-in');
                        }, 250);

                    }, 250);
                }
            });
        }
    });

    $(document).on('click', '.file-down-btn, .del-file-down-btn', function () {
        let $row = $(this).closest('tr');

        let filePath = $row.find('input[type="hidden"][name="filePath"]').val();
        let fileTitle = $row.find('input[type="hidden"][name="fileTitle"]').val();

        let file = {
            filePath: filePath,
            fileTitle: fileTitle
        }

        fetch('/projects/outputs/api/download', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(file)
        })
            .then(response => {
                const fileName = response.headers.get('Content-Disposition').match(/filename\*?="?(?:UTF-8''?)?([^";]+)"?;?/)[1];
                return response.blob().then(blob => ({ blob, fileName }));
            })
            .then(({ blob, fileName }) => {
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = decodeURIComponent(fileName);
                document.body.appendChild(a);
                a.click();
                a.remove();
                window.URL.revokeObjectURL(url);
            })
            .catch(error => console.error('Error downloading files:', error));
    });

    $('#file-delete-btn').on('click', function (e) {
        e.preventDefault();

        let files = grid.getList("selected");

        let fileIds = [];
        if (files.length > 0) {
            files.forEach(function (file) {
                fileIds.push(file.fileItem.fileNo);
            });
        } else {
            alert("선택된 파일이 없습니다.");
            return;
        }
        console.log(fileIds);

        $.ajax({
            url: '/projects/outputs/api/deletefile',
            method: 'post',
            contentType: 'application/json',
            data: JSON.stringify({ files: fileIds }),
            success: function (response) {
                alert('파일이 성공적으로 삭제되었습니다.');
                window.location.href = '/projects/outputs';
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.error('삭제 요청 중 오류 발생:', textStatus, errorThrown);
                alert('삭제 요청 중 오류가 발생했습니다.');
            }
        });
    });
});

$(function () {
    $('#newFolder').on('click', function () {
        $('#folderModal').modal('show');
    });

    $('#file-insert').on('click', function () {
        $('#fileInsertModal').modal('show');
    });

    $('#file-delete-his-btn').on('click', function () {
        openHistoryModal();
    });

    $('#output-save-btn').on('click', function () {
        $.ajax({
            url: '/projects/outputs/api/update',
            method: 'patch',
            data: {
                title: $('#outputTitle').val(),
                outputNo: selectedNodeId
            },
            success: function (response) {
                alert('산출물 정보가 저장 되었습니다.');
                window.location.href = '/projects/outputs';
            },
            error: function (xhr, status, error) {
                alert('산출물 등록 중 에러가 발생했습니다.');
            }
        })
    });
    
    $('#output-delete-btn').on('click', function () {
       $.ajax({
              url: '/projects/outputs/api/delete',
              method: 'delete',
              data: {
                outputNo: selectedNodeId
              },
              success: function (response) {
                alert('산출물이 성공적으로 삭제 되었습니다.');
                window.location.href = '/projects/outputs';
              },
              error: function (xhr, status, error) {
                alert('산출물 삭제 중 에러가 발생했습니다.');
              }
       });
    });

    $('.download-btn').on('click', function () {
        let selected = grid.getList("selected");
        let files = selected.map(file => ({
            filePath: file.fileItem.filePath,
            fileTitle: file.fileItem.fileTitle // 파일 타이틀을 추가
        }));
        console.log(files);

        fetch('/projects/outputs/api/downloadmultiple', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(files) // 객체 배열을 JSON 형식으로 변환
        })
            .then(response => response.blob())
            .then(blob => {
                const url = window.URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = "files.zip"; // 다운로드 파일 이름
                document.body.appendChild(a);
                a.click();
                a.remove();
                window.URL.revokeObjectURL(url);
            })
            .catch(error => console.error('Error downloading files:', error));
    });
});

// 산출물 파일 상세 모달
function loadVersionHistory(historyElement) {
    let versionHistory;
    $.ajax({
        url: '/projects/outputs/api/delete?outputNo=' + selectedNodeId,
        method: 'GET',
        success: function(response) {
            versionHistory = response;
            historyElement.empty();

            const table = $(`
        <table class="table table-striped version-history-table">
            <thead>
                <tr>
                    <th style="text-align: center;">&nbsp;&nbsp;&nbsp;</th>
                    <th style="text-align: center;">파일명</th>
                    <th style="text-align: center;">삭제자</th>
                    <th style="text-align: center;">삭제일자</th>
                    <th style="text-align: center;">옹량</th>
                    <th style="text-align: center;">파일형식</th>
                    <th style="text-align: center;">다운로드</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    `);

            const tbody = table.find('tbody');

            versionHistory.forEach(version => {
                const row = $(`
            <tr>
                <td style="text-align: center;">
                    <img data-dz-thumbnail src='../../../../resources/output/images/file-icon.png' style="width: 30px;"/>
                </td>
                <td style="text-align: left;">
                    <input type="hidden" value="${version.filePath}">
                    <input type="hidden" value="${version.fileTitle}">
                    ${version.fileTitle}
                </td>
                <td style="text-align: center;">${version.deleteName}</td>
                <td style="text-align: center;">${formatDate(version.deletedDate)}</td>
                <td style="text-align: center;">${formatBytes(version.fileSize)}</td>
                <td class="ellipsis" style="text-align: center;">${version.fileType}</td>
                <td style="text-align: center;">
                    <button class="green-btn del-file-down-btn">&nbsp;&nbsp;다운로드&nbsp;&nbsp;</button>
                </td>
            </tr>
        `);
                tbody.append(row);
            });

            historyElement.append(table);
        },
    });
}

function openHistoryModal() {
    const $historyModal = $('#historyModal');
    loadVersionHistory($historyModal.find('.versionHistory'));
    $historyModal.modal('show');
}

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

function createLabel(value) {
    const optionText = $selectElement.find('option[value="' + value + '"]').text();
    const $label = $('<div>', {
        class: 'label-item',
        text: optionText
    });

    const $removeBtn = $('<button>', {
        class: 'remove-btn',
        html: '&times;'
    });

    $removeBtn.on('click', function () {
        $label.remove();
        selectedOptions = selectedOptions.filter(function (val) {
            return val !== value;
        });
    });

    $label.append($removeBtn);
    $selectBox.append($label);
}

function formatBytes(bytes, decimals = 2) {
    if (bytes === 0) return '0 Bytes';

    const k = 1024;
    const dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    const i = Math.floor(Math.log(bytes) / Math.log(k));

    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('ko-KR');  // 'ko-KR'은 한국어 날짜 형식을 의미합니다.
}

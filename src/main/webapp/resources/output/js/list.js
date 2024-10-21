// jstree
$(function () {
    // 노드 이동 이벤트 핸들러
    $('.jstree-files').on("move_node.jstree", function (e, data) {
        let movedNode = data.node;
        let newParentId = data.parent;
        updateTreeData(movedNode, newParentId);
    });

    // treeData 업데이트 함수
    function updateTreeData(movedNode, newParentId) {
        // 이동된 노드를 treeData에서 제거
        let node = removeNodeById(treeData, movedNode.id);

        // 새로운 부모 노드에 추가
        if (newParentId === '#') {
            // 최상위 노드로 이동
            treeData.push(node);
        } else {
            let parentNode = findNodeById(treeData, newParentId);
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
            if (nodes[i].id === id) {
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
        }
    });

    // 초기 상태에서 드래그 앤 드롭 비활성화
    $('.jstree-files').jstree(true).settings.dnd.is_draggable = function () {
        return false;
    };

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

// file grid
let gridData = [
    {
        fileName: "A 업무 시스템 요구사항 정의서_1",
        fileType: "xls/xlsx",
        size: "2.1MB",
        version: "0.1",
        date: "2024-02-17",
        author: "이수호"
    },
    {
        fileName: "A 업무 시스템 요구사항 정의서_2",
        fileType: "xls/xlsx",
        size: "1.77MB",
        version: "0.1",
        date: "2024-02-17",
        author: "이수호"
    }
];
$(function () {
    let grid = new ax5.ui.grid();
    grid.setConfig({
        target: $('[data-ax5grid="my-grid"]'),
        showRowSelector: true,
        multipleSelect: true,
        columns: [
            {key: "fileName", label: "파일명", width: 261.6, align: "center"},
            {key: "fileType", label: "파일형식", width: 80, align: "center"},
            {key: "size", label: "용량", width: 80, align: "center"},
            {key: "date", label: "날짜", width: 100, align: "center"},
            {key: "author", label: "작성자", width: 80, align: "center"},
            {
                key: null,
                label: "작업",
                width: 100,
                align: "center",
                formatter: function () {
                    return `
                        <div class="d-flex justify-content-center">
                            <button class="ms-1 file-btn" data-file="${this.item.fileName}">&nbsp;다운로드&nbsp;</button>
                        </div>
                    `;
                }
            }
        ]
    });

    grid.setData(gridData);
    $('#detail-cnt').text(gridData.length);
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
});

// 산출물 파일 상세 모달
function loadVersionHistory(historyElement) {
    const versionHistory = [
        {fileName: "5차", fileSize: "2.01 MB", deleted_nm: "홍길동", deletedDate: "2024-02-14", fileType: "xls/xlsx"},
        {fileName: "4차", fileSize: "1.92 MB", deleted_nm: "홍길동", deletedDate: "2024-02-07", fileType: "xls/xlsx"},
        {fileName: "3차", fileSize: "1.77 MB", deleted_nm: "홍길동", deletedDate: "2024-01-29", fileType: "xls/xlsx"},
        {fileName: "2차", fileSize: "1.58 MB", deleted_nm: "홍길동", deletedDate: "2024-01-11", fileType: "xls/xlsx"},
        {fileName: "초안", fileSize: "1.26 MB", deleted_nm: "홍길동", deletedDate: "2024-01-03", fileType: "xls/xlsx"},
        {fileName: "초안", fileSize: "1.26 MB", deleted_nm: "홍길동", deletedDate: "2024-01-03", fileType: "xls/xlsx"}
    ];

    historyElement.empty();

    // 테이블 생성
    const table = $(`
        <table class="table table-striped version-history-table">
            <thead>
                <tr>
                    <th style="text-align: center;">&nbsp;&nbsp;&nbsp;</th>
                    <th style="text-align: center;">파일명</th>
                    <th style="text-align: center;">삭제자</th>
                    <th style="text-align: center;">삭제일</th>
                    <th style="text-align: center;">크기</th>
                    <th style="text-align: center;">형식</th>
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
                <td style="text-align: left;">${version.fileName}</td>
                <td style="text-align: center;">${version.deleted_nm}</td>
                <td style="text-align: center;">${version.deletedDate}</td>
                <td style="text-align: center;">${version.fileSize}</td>
                <td style="text-align: center;">${version.fileType}</td>
                <td style="text-align: center;">
                    <button class="green-btn">&nbsp;&nbsp;다운로드&nbsp;&nbsp;</button>
                </td>
            </tr>
        `);
        tbody.append(row);
    });

    historyElement.append(table);
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
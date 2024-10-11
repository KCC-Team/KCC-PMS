$(function() {
    let treeData = [
        {
            id: "1",
            text: "차세대 프로그램 구축",
            type: "folder",
            children: [
                {
                    id: "1.1",
                    text: "요구사항 정의서",
                    type: "output",
                },
                {
                    id: "1.2",
                    text: "요구사항추적표(설계)",
                    type: "output",
                },
            ],
        },
        {
            id: "2",
            text: "B 프로그램 구축",
            type: "folder",
            children: [
                {
                    id: "2.1",
                    text: "개발환경 설치 작업계획서",
                    type: "output",
                },
            ],
        },
    ];

    function convertToJsTreeData(nodes, parentId) {
        let jsTreeData = [];
        nodes.forEach(function(node) {
            let jsTreeNode = {
                id: node.id,
                parent: parentId || '#',
                text: node.text,
                type: node.type
            };
            jsTreeData.push(jsTreeNode);
            if (node.children && node.children.length > 0) {
                jsTreeData = jsTreeData.concat(convertToJsTreeData(node.children, node.id));
            }
        });
        return jsTreeData;
    }

    let jsTreeData = convertToJsTreeData(treeData);
    window.jsTreeInstance = $('.jstree-files').jstree({
        'core': {
            'data': jsTreeData,
            "themes" : { "stripes" : true },
            'check_callback': true
        },
        'plugins': ["types", "dnd", "wholerow", "search"],
        'types': {
            "default": {
                "icon": "fa fa-folder text-warning"
            },
            "file": {
                "icon": "fa fa-file text-info"
            },
            "output": {
                "icon": "fa-solid fa-box-archive text-success"
            }
        }
    });

    window.jsTreeFolderInstance = $('.jstree-folder').jstree({
        'core': {
            'data': jsTreeData,
            "themes" : { "stripes" : true },
            'check_callback': true
        },
        'plugins': ["types", "dnd", "wholerow", "search"],
        'types': {
            "default": {
                "icon": "fa fa-folder text-warning"
            },
            "output": {
                "icon": "fa-solid fa-box-archive text-success"
            }
        }
    });
});

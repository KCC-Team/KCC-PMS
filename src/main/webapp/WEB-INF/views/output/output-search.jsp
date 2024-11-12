<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>산출물 검색</title>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/themes/default/style.min.css" />
    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5core/master/dist/ax5core.min.js"></script>
    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-grid/master/dist/ax5grid.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-toast/master/dist/ax5toast.css" />
    <script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-toast/master/dist/ax5toast.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.12/jstree.min.js"></script>

    <script src="../../../resources/output/js/jstree.js"></script>
</head>

<style>
    body {
        font-family: NanumGothic,NanumBarunGothic,"Apple SD Gothic Neo","Malgun Gothic",Dotum,sans-serif !important;
        color: #666;
    }

  .div-section {
    display: flex;
    padding-top: 15px;
    align-items: center;
  }

  .div-info {
    font-size: 20px;
    font-weight: bold;
    border-bottom: 1px solid #989898;
    width: 94%;
    margin: 4px 0px 20px 40px;
    padding-bottom: 5px;
    float: left;
    color: #000;
  }

  .jstree-layout {
    overflow-y: auto;
    width: 400px;
    height: 350px;
    border: 1px solid #656565;
  }

  .addedFiles {
    width: 40%;
    height: 350px;
    border: 1px solid #000000;
  }

  .added-files-layout {
    border-top: 1px solid #989898;
    height: 300px;
    overflow-y: auto;
  }

  .added-files-layout .file-list-item {
    width: 100%;
    margin-bottom: 5px;
    background-color: #f8f8f8;
    padding: 3px;
    border-radius: 5px;
    display: flex;
    justify-content: space-between;
      align-items: center;
  }

  .added-files-layout .remove-btn {
    border: none;
    background-color: red;
    color: white;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
  }

  button {
    padding: 6px 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  button.save-btn {
    background-color: #1F80DA;
    color: white;
  }

  button.cancel-btn {
    background-color: #8B8B8B;
    color: white;
  }

  #search-output {
      width: 300px;
      height: 30px;
      margin-left: 40px;
      border: 1px solid #4f4e4e;
  }

  .modal-footer {
      margin: 10px;
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 11px;
  }

  .btn-save-output {
      padding: 5px 9px 5px 9px !important;
      border: none;
      border-radius: 5px;
      color: white;
      cursor: pointer;
      background-color: #1F80DA;
      font-size: 15px !important;
  }

  .btn-close-output {
      padding: 5px 9px 5px 9px;
      border: none;
      border-radius: 5px;
      color: white;
      cursor: pointer;
      background-color: gray;
  }

</style>

<body>
  <div class="jstree-section" style="height: 87%">
    <div class="div-section">
      <label class="div-info">
        산출물 검색</label>
    </div>
    <div>
      <input type="text" class="form-control" id="search-output" placeholder="산출물을 검색하세요.">
    </div>
    <section class="d-flex justify-content-left ms-4 p-3">
      <section class="jstree-layout">
        <jsp:include page="jstree.jsp" />
      </section>
      <section class="d-flex align-items-center">
        <img src="../../../resources/output/images/right.png" style="width: 75px; height: 75px">
      </section>
      <section class="addedFiles">
        <div class="d-flex justify-content-center mb-1">
          <label>추가된 산출물</label>
        </div>
        <div class="added-files-layout">
        </div>
      </section>
    </section>
    <section>
        <div class="modal-footer">
            <button type="submit" class="btn-save-output">저장</button>
            <button onclick="window.close();" class="btn-close-output">닫기</button>
        </div>
    </section>

  </div>
</body>

<script>
  let selectedFiles = [];
  $(function() {
    let to = false;
    $('#search-output').keyup(function () {
      let v = $('#search-output').val();
      $('.jstree-files').jstree(true).search(v);
    });
  });

  $('.jstree-files').on("dblclick.jstree", ".jstree-anchor", function (e) {
    let node = $('.jstree-files').jstree(true).get_node($(this));
    if (!selectedFiles.some(file => file.id === node.id) && (!(node.type === 'y') && !(node.type === 'default'))) { // 중복 선택 방지
      console.log(node.type);
      selectedFiles.push(node);
      updateFileList();
    }

    console.log(selectedFiles);
  });

  function updateFileList() {
    let $layout = $('.added-files-layout');
    $layout.empty();
    selectedFiles.forEach(function(file, index) {
      let $row = $('<div>').addClass('file-list-item').text(file.text)
              .append($('<button>').text('X').addClass('remove-btn')
                      .on('click', function() {
                        removeFile(index);
                      }));
      $layout.append($row);
    });
  }

  function removeFile(index) {
    selectedFiles.splice(index, 1);
    updateFileList();
    console.log(selectedFiles);
  }

  // 저장 버튼 클릭
  $(document).on('click', '.btn-save-output', function() {
      if (window.opener) {
          const messageData = {
              type: "output",       // 구분값
              files: selectedFiles  // 파일 데이터
          };
          window.opener.postMessage(messageData);
          window.close();
      }
  });

</script>
</html>

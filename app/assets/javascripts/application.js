// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require_tree .


// 投稿写真のプレビュ
$(function(){
	// DataTransferオブジェクトで、データの入れ物を作る
	var dataBox = new DataTransfer();
	// file_fieldを取得
	var file_field = document.querySelector('input[type=file]')
	// fileが選択された時の処理
	$('#post_image').change(function(){
		// 選択したfileを取得
		var file = $('input[type="file"]').prop('files')[0];
		$.each(this.files, function(i, file){
		// fileオブジェクトの読み込み
		var fileReader = new FileReader();

		// DataTransferオブジェクトに対して、fileを追加
		dataBox.items.add(file)
		// file一覧をfile_fieldに入れる
		file_field.files = dataBox.files

		var num = $('.post_image').length + 1 + i
		fileReader.readAsDataURL(file);

		// 読み込み後に、srcにfileURLを入れる
		fileReader.onloadend = function(){
			var src = fileReader.result
			var html= `<div class='post_image' data-image="${file.name}"">
							<div class='post_image'>
					   			<img src="${src}" width="200" height="200">
					   			<div class='post_image-delete'>削除</div>
					   		</div>
					   </div>`
			// htmlに挿入
			$('#image-box_container').before(html);
		};
	  	});
	});

	$(document).on("click", '.post_image-delete',function(){
	// プレビューの情報取得
	$(this).parent().parent().remove();
	$('input[type=file]').val('');
	})
});


// ユーザの写真プレビュ
$(document).on('turbolinks:load', function() {
$(function(){
    // inputのidから情報の取得
    $('[id$=_image_preview]').on('change', function (e) {
// ここから既存の画像のurlの取得
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".image").attr('src', e.target.result);
    }
// ここまで
    reader.readAsDataURL(e.target.files[0]); //取得したurlにアップロード画像のurlを挿入
});
});
});





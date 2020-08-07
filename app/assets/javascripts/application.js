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

$(function(){
	// file_fieldを取得
	var file_field = document.querySelector('input[type=file]')
	// fileが選択された時の処理
	$('#post_image').change(function(){
		// 選択したfileを取得
		var file = $('input[type="file"]').prop('files')[0];
		// fileオブジェクトの読み込み
		var fileReader = new FileReader();
		// 読み込み後に、srcにfileURLを入れる
		fileReader.onloadend = function(){
			var src = fileReader.result
			var html= `<div class='post_image data-image="${file.name}"">
							<div class='post_image'>
					   			<img src="${src}" width="200" height="200">
					   		</div>
					   		<div class='post_image-delete'>削除</div>
					   </div>`
			// htmlに挿入
			$('#image-box_container').before(html);
		}
		fileReader.readAsDataURL(file);
	});

	$(document).on("click", '.post_image-delete',function(){
	// プレビューの情報取得
	var click_image = $(this).parent()
	// クリックしたプレビューを削除
	click_image.remove();
	})
});



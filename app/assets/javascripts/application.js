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
$(document).on('turbolinks:load', function() {
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
				var html= `<div class='post_image' data-image='${file.name}'>
								<div class='post_image_content'>
									<div>
						   				<img src=${src} width="200" height="200">
						   			</div>
						   		</div>
						   		<div>
						   			<div class='post_image-delete'>削除</div>
						   		</div>
						   </div>`
				// htmlに挿入
				$('#image-box_container').before(html);
			};
				// $('#image-box__container').attr('class', `post-num-${num}`)
		  	});
		});

		$(document).on("click", '.post_image-delete',function(){
		// プレビューの情報取得
			var target_image = $(this).parent().parent()

			//  削除されたimageのfile名を取得
			var target_name = target_image.data('image')

			// プレビューが一つだけの時に
			if(file_field.files.length==1){
				// inputのファイルを削除
				$('input[type=file]').val(null)
				dataBox.clearData();
				console.log(dataBox)
			}else{
				// プレビューが複数の場合
				$.each(document.querySelector('input[type=file]').files, function(i,input){
					if(document.querySelector('input[type=file]').files[i].name == target_name){
						dataBox.items.remove(i)
					}
				})
				// DataTransferに入ったfile一覧をfile_fieldに再度代入
				file_field.files = dataBox.files
			}
			// プレビューの削除
			target_image.remove();

			// var num = $('.post_image').length
			// $('#image-box_container').show()
			// $('#image-box_container').attr('class',`post-num-${num}`)
		})
	});
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


// slick
$(document).on('turbolinks:load', function(){
	$(".slick").slick({
		autoplay:true,
		autoplaySpeed:3000,
		speed: 500,
	});
});

$(document).on('turbolinks:load', function(){
	$(".slick_index").slick({
		arrows: true,
		accessibility: true,
		zcenterMode: true,
    	nextButton: '.swiper-button-next',
    	prevButton: '.swiper-button-prev'
	});

	$(".slick_index").hover(
		function(){
			$(".slick-prev").css("display",'block');
			$(".slick-next").css("display",'block');
		},
		function(){
			$(".slick-prev").css("display",'none');
			$(".slick-next").css("display",'none');
		}
		);
});


// 投稿する写真の国によって選択内容が変わる
$(document).on('turbolinks:load', function() {
$(function(){
	$(".country-select").change(function(){
		// 選択したらタグを作る
		// var tag = $(".country-select option:selected").text();
		// $(".label-select").last().append("<label><input type='checkbox' checked='checked' name='post[]' id='post_tag_ids_8' ></label>" + $('.country-select option:selected').text());
		// 選択したものが日本かそれ以外かで選択肢を変える。
		if($(".country-select").val() == "JP"){
			$(".prefecture").css('display','table-row');
			$(".city").css("display", 'none');
		}else{
			$(".city").css('display','table-row');
			$(".prefecture").css("display", 'none');
		}
	});
});
});




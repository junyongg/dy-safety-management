/**
 * @license Copyright (c) 2003-2018, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

//CKEDITOR.editorConfig = function( config ) {
// 
//    config.toolbar = [
//        { name: 'document', items: [ 'Source' ] },
//        { name: 'clipboard', items: [ 'Undo', 'Redo' ] },
//        { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike'] },
//        { name: 'links', items: [ 'Link', 'Unlink'] },
//        { name: 'insert', items: [ 'Table' ] },
//        { name: 'styles', items: [ 'Font', 'FontSize' ] },
//        { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
//        { name: 'tools', items: [ 'Maximize'] },
//    ];
// 
//    config.extraAllowedContent = 'img[src,alt]'; // setData()에 img 허용
//    config.font_defaultLabel = '맑은 고딕'; // 기본 폰트 지정
//    config.font_names =  '맑은 고딕; 돋움; 바탕; 돋음; 궁서;'; // 폰트 목록
//    config.fontSize_defaultLabel = '12px'; // 기본 폰트 크기 지정
//    config.fontSize_sizes = '12/12px;14/14px;16/16px;'; // 폰트 크기
//    config.language = "ko"; // 언어타입
//    config.resize_enabled = true; // 에디터 크기 조절 사용여부
//    config.enterMode = CKEDITOR.ENTER_BR; // 엔터시 <br> 
//    config.shiftEnterMode = CKEDITOR.ENTER_P; // 쉬프트+엔터시 <p>
//    config.toolbarCanCollapse = false; // 툴바 클릭시 접히는 여부
//    config.menu_subMenuDelay = 0; // 메뉴 클릭 할 때 딜레이 값
//    config.autoParagraph = false;
//    config.protectedSource.push(/<\?[\s\S]*?\?>?/g);
//    config.height = 400;
//    //config.startupFocus = true; // 글쓰기 시작시 포커스 사용여부
//};

/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {

 config.docType = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';
 config.font_defaultLabel = 'Gulim';
 config.font_names = '맑은 고딕; 돋움; 바탕; 돋음; 궁서;Gulim;Dotum;Batang;Gungsuh;Arial/Arial;Tahoma/Tahoma;Verdana/Verdana';
 config.fontSize_defaultLabel = '12px';
 config.fontSize_sizes = '8/8px;9/9px;10/10px;11/11px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;36/36px;48/48px;';
 config.language = "ko";
 config.resize_enabled = true;    // 사이즈 변경
 config.enterMode = CKEDITOR.ENTER_BR;  // 에디터상에서 엔터입력시 <br />로 적용
 //config.enterMode = CKEDITOR.ENTER_P;  // 에디터상에서 엔터입력시 <p />로 적용
 config.shiftEnterMode = CKEDITOR.ENTER_P; // shift + enter 시 <p> 로 적용
 config.startupFocus = false;     // 시작시 포커스 설정
 config.uiColor = '#EEEEEE';
 config.toolbarCanCollapse = false;   // 툴바 클릭시 접히는 여부
 config.menu_subMenuDelay = 0;    // 메뉴 클릭시 딜레이값
 config.allowedContent = true;    // 기본적인 html이 필터링으로 지워지는데 필터링을 하지 않는다.
 config.extraPlugins = 'cloudservices';
 //config.protectedSource.push( /<%[\s\S]*?%>/g ) ;  // ASP style server side code <%...%>
   //config.protectedSource.push( /<\?[\s\S]*?\?>/g ) ;  // PHP style server side code
   //config.protectedSource.push( /(<asp:[^\>]+>[\s|\S]*?<\/asp:[^\>]+>)|(<asp:[^\>]+\/>)/gi ) ; // ASP.Net style tags <asp:control>
   //config.protectedSource.push( /<body[\s\S]*?>/i ) ; // body tag
   //config.protectedSource.push( /<\/body>/i ) ; // body tag
   
   //Whether the editor must output an empty value ('') if it's contents is made by an empty paragraph only.
   config.ignoreEmptyParagraph = true;

   //Whether to use HTML entities in the output. ', "
   config.entities = false;

   //config.htmlEncodeOutput = false;

   //Whether to escape basic HTML entities in the document, including: nbsp gt lt amp 
   //config.basicEntities = false;

   config.fillEmptyBlocks = false; // Prevent filler nodes in all empty blocks.

   // Make dialogs simpler.
   config.removeDialogTabs = 'image:advanced;link:advanced';
   
   //This option makes it possible to set additional allowed content rules
   //config.extraAllowedContent ='';
 
 
 //툴바 셋팅
 config.toolbar = [
  { name: 'document', items: [ 'Source' ] },
  { name: 'clipboard', items: [ 'Undo', 'Redo' ] },
  { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent'] },
  { name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule', 'SpecialChar' ] },
  { name: 'tools', items: [ 'Maximize' ] },
  '/',
  { name: 'styles', items: [ 'Font', 'FontSize' ] },
  { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', '-', 'RemoveFormat' ] },
  { name: 'colors', items: [ 'TextColor'] },
  { name: 'paragraph', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
  { name: 'about', items: [ 'About' ] }
 ];
 
 
/* CKEDITOR.on('dialogDefinition', function (ev) {
            var dialogName = ev.data.name;
            var dialog = ev.data.definition.dialog;
            var dialogDefinition = ev.data.definition;
            if (dialogName == 'image') {
                dialog.on('show', function (obj) {
                    this.selectPage('Upload'); //업로드텝으로 시작
                });
                dialogDefinition.removeContents('advanced'); // 자세히탭 제거
                dialogDefinition.removeContents('Link'); // 링크탭 제거
    
   var infoTab = dialogDefinition.getContents( 'info' );  //info탭을 제거하면 이미지 업로드가 안된다.
   // Remove unnecessary widgets/elements from the 'Image Info' tab.
   infoTab.remove( 'txtHSpace'); //info 탭 내에 불필요한 엘레멘트들 제거
            }
        });*/
  
};
 
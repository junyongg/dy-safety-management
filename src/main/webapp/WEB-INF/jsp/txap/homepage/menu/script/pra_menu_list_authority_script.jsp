<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglib/taglib.jspf"%>


<script>

$(function(){
	pf_create_layerDialog("Authority-manager", "insert","권한 관리","pf_Authority_manager()");
	pf_setAuthorityTab()
})

//게시판일때 권한쪽 추가 셋팅
function pf_setAuthorityTab(){
	 $.ajax({
			type: "POST",
			url: "/txap/homepage/menu/authority/subAuthorityAjax.do",
			async :false,
			success : function(data){
				$.each(data,function(i){
					var temp = "<li class=\"boardTab "+data[i].UIR_NAME+"Tab\">";
					temp += "<a href=\"#"+data[i].UIR_NAME+"Authority\" data-toggle=\"tab\" aria-expanded=\"true\">"+data[i].UIR_COMMENT+"</a></li>";
					$('#authorityTab').append(temp);
					$tabContents = $('#accessAuthority').clone();
					$tabContents.removeClass('active in');
					$tabContents.attr('id',data[i].UIR_NAME+"Authority");
					$tabContents.find('input[name=M_KEYNO]').val(data[i].UIR_KEYNO)
					$tabContents.find('.authority-setting-name').text(data[i].UIR_COMMENT)
					$tabContents.find('input[name=M_TYPE]').attr({
						'name'  : 'M_TYPE_'+data[i].UIR_NAME
					})
					$('#authorityTabContent').append($tabContents)
				})
				
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert('알수없는 에러 발생. 관리자한테 문의하세요.')
				state = false;
			}
	   });
	
	
}


//권한 관리 모달창 오픈
function pf_OpenAuthorityManager(KEYNO,URL,PAGEDIV){
	  
	  if(PAGEDIV == 'SC_TFOVO'){ // 게시판 타입
		  $('.boardTab').show();
		  $.ajax({
				type: "POST",
				url: "/txap/homepage/menu/authority/getBTInfoAjax.do",
				data:"MN_KEYNO="+KEYNO,
				async :false,
				success : function(data){
					if(data.BT_REPLY_YN == 'N'){
						$('.replyTab').hide();
					}
					if(data.BT_COMMENT_YN == 'N'){
						$('.commentTab').hide();
					}
					
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert('알수없는 에러 발생. 관리자한테 문의하세요.')
					state = false;
				}
		   });	
	  
	  
	  
	  }else{
		  $('.boardTab').hide();
	  }
	  
	  $('#MN_KEYNO').val(KEYNO);	 
	  if(URL.indexOf('.do') == -1){
		  $('#MN_URL').val(URL+"/**")
	  }else{
		  $('#MN_URL').val(URL)
	  }
	  
	  var state = true;
	  $.ajax({
			type: "POST",
			url: "/txap/homepage/menu/authority/listAjax.do",
			async :false,
			success : function(data){
				var temp = '';
				$.each(data,function(i){
					if(data[i].UIA_KEYNO != '${AUTHORITY_ADMIN}'){
						temp += '<tr>';
						temp += '<td><label class="checkbox" style="padding-top:0">';
						temp += '<input type="checkbox" name="authority_key" value="' + data[i].UIA_KEYNO + '"><i></i>';
						temp += '</label></td>';
						temp += '<td>' + data[i].UIA_NAME + '</td>';
						/* temp += '<td>' + (data[i].UIA_TYPE == 'A' ? '관리자': (data[i].UIA_TYPE == 'U' ? '일반유저':'기타') ) + '</td>'; */
						temp += '<td>' + data[i].UIA_COMMENT + '</td>';
						temp += '</tr>';
					}
				})
				$('.authorityTable table tbody').html(temp);
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert('권한 리스트를 가져올 수 업습니다. 관리자한테 문의하세요.')
				state = false;
			}
	   });
	   
	  if(!state){
		  return false;
	  }
	  
	  $('.authority-detail-setting').hide();
	  
	  $('#authorityTab li').eq(0).find('a').trigger('click');
	  $('input:checkbox[name=authority_key]').prop('checked',false);
	  $('input[name^=M_TYPE]').prop('checked',false);
	  
	  $.ajax({
			type: "POST",
			url: "/txap/homepage/menu/authority/nameListAjax.do",
			data: "MN_KEYNO="+$('#MN_KEYNO').val(),
			async :false,
			success : function(data){
				$.each(data,function(i){
					var id = '#'+data[i].UIR_NAME+'Authority';
					var type = data[i].TYPE;
					$(id+' input:radio[name^=M_TYPE][value='+type+']').prop('checked',true);
					if(type == 'C'){
						$(id+' .authority-detail-setting').show();
						if(data[i].AUTHORITY_LIST){
							var authorityList = data[i].AUTHORITY_LIST.split(',');
							$.each(authorityList,function(i){
								$(id+' input:checkbox[name=authority_key][value='+authorityList[i]+']').prop('checked',true);
							})
						}
					}
				})
				
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert('알수없는 에러 발생. 관리자한테 문의하세요.')
				return false;
			}
	   });
	  
	  
	  $('input[name^="M_TYPE"]').change(function(){
		  if($(this).val() == 'C'){
			  $(this).parents('.tab-pane').find('.authority-detail-setting').show();
			  
		  }else{
			  $(this).parents('.tab-pane').find('.authority-detail-setting').hide();
		  }
	  });
	  
	  $('input[name=authority_keyAll]').change(function(){
		  if($(this).prop('checked')){
			  $(this).parents('.tab-pane').find('input[name=authority_key]').prop('checked',true);
		  }else{
			  $(this).parents('.tab-pane').find('input[name=authority_key]').prop('checked',false);
		  }
	  })
	  
	  $('#Authority-manager').dialog('open');
	  
	  
}

//권한 관리 설정
function pf_Authority_manager(){
	  
	  var type = $('#accessAuthority input[name=M_TYPE]:checked').val();
	  if(!type){
		  alert('접근 권한 설정을 체크하여주세요.')
		  return false;
	  }
	  // form
	  var form = document.createElement("form");     
	  form.setAttribute("method","post");                    
	  document.body.appendChild(form);                        
	  form.appendChild(pf_createInput("MN_URL", $('#MN_URL').val()));
	  form.appendChild(pf_createInput("MN_KEYNO", $('#MN_KEYNO').val())); 
	  $('.tab-pane').each(function(){
		  type = $('input[name^=M_TYPE]:checked',this).val();
		  if(type){
			  
			  form.appendChild(pf_createInput("key", $('input[name=M_KEYNO]',this).val()));
			  form.appendChild(pf_createInput("type", type));
			  if(type == 'C'){
				  var data = new Array();
				  data.push('${AUTHORITY_ADMIN}'); // '관리자' key
				  $('input[name=authority_key]:checked',this).each(function(){
					  data.push($(this).val())
				  });
				  form.appendChild(pf_createInput("data", data.join('|')));
			  }else{
				  form.appendChild(pf_createInput("data", " "));
			  }
		  }
	  })
	  $.ajax({
			type: "POST",
			url: "/txap/homepage/menu/authority/insertAjax.do",
			data: $(form).serializeArray(),
			async :false,
			success : function(data){
				if(data != 'success'){
					alert('type :: '+data+'\n타입설정에 오류가 있습니다. 관리자한테 문의하세요.');
				}else{
					alert('성공적으로 설정되었습니다.')
				}
				
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert('알수없는 에러 발생. 관리자한테 문의하세요.')
				return false;
			}
	   });
	  
	  $(form).remove();
	  
	  
	  return true;
}

function pf_createInput(key,value){
	var input_id = document.createElement("input");  
	  input_id.setAttribute("type", "hidden");                 
	  input_id.setAttribute("name", key);                        
	  input_id.setAttribute("value", value);                          
	  return input_id;
}

</script>
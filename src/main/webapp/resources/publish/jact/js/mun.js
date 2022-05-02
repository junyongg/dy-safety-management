function setTap(tapId){
							var tab1 = document.getElementsByClassName('tab1');
							var tab2 = document.getElementsByClassName('tab2');
							var tab3 = document.getElementsByClassName('tab3');
                      var tab4 = document.getElementsByClassName('tab4');
                      var tab5 = document.getElementsByClassName('tab5');
							
                      var li1 = document.getElementsByClassName('li1');
							var li2 = document.getElementsByClassName('li2');
							var li3 = document.getElementsByClassName('li3');
                      var li4 = document.getElementsByClassName('li4');
                      var li5 = document.getElementsByClassName('li5');
				
						if(tapId == 1){
						   
							$(tab1).addClass('active');
							$(tab2).removeClass('active');
							$(tab3).removeClass('active');
                        $(tab4).removeClass('active');
                        $(tab5).removeClass('active');
							
							
							$(li1).show();
							$(li2).hide();
							$(li3).hide();
                      $(li4).hide();
                      $(li5).hide();
				
						}else if(tapId == 2){
						   
							$(tab1).removeClass('active');
							$(tab2).addClass('active');
							$(tab3).removeClass('active');
				  			$(tab4).removeClass('active');
                        $(tab5).removeClass('active');
						   
				
							$(li1).hide();
							$(li2).show();
							$(li3).hide();
                            $(li4).hide();
                          $(li5).hide();
				
						}else if(tapId == 3){
							$(tab1).removeClass('active');
							$(tab2).removeClass('active');
							$(tab3).addClass('active');
				  			$(tab4).removeClass('active');
                       $(tab5).removeClass('active');
						   
				
							$(li1).hide();
							$(li2).hide();
							$(li3).show();
                       $(li4).hide();
                       $(li5).hide();
						}else if(tapId == 4){
							$(tab1).removeClass('active');
							$(tab2).removeClass('active');
							$(tab3).removeClass('active');
				  			$(tab4).addClass('active');
                       $(tab5).removeClass('active');
                          
                       $(li1).hide();
							$(li2).hide();
							$(li3).hide();
                       $(li4).show();
                       $(li5).hide();
						}else{
                       $(tab1).removeClass('active');
							$(tab2).removeClass('active');
							$(tab3).removeClass('active');
				  			$(tab4).removeClass('active');
                       $(tab5).addClass('active');
                          
                       $(li1).hide();
							$(li2).hide();
							$(li3).hide();
                       $(li4).hide();
                       $(li5).show();
                        }
					}	
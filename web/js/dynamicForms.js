$(document).ready(function() {

  let questions =  $('.question-item');
  let item = '#question-0-type_id';
  let add_answer_btns = $('.add-answer');
  let remove_answer_btns = $('.remove-answer');
  
  
  if ( questions.length == 1){
    $('.question-number').append(1);
    $(item).on('change', function(){
        
      if ($(this).val() == 4){
        for( let j = 1; j <= 9; j++){
          let answer = $('.field-answer-0-' + j + '-title');
          let a_item = answer.parents('.answer-item');
          a_item.detach();
        }
        $(add_answer_btns[0]).addClass('disabled');
        $(remove_answer_btns[0]).addClass('disabled');
        $('.field-answer-0-0-title').removeClass('required');
        $('#answer-0-0-title').removeClass('is-invalid');
        $('#answer-0-0-title').attr('disabled', '');
        $('#answer-0-0-true_false').addClass('d-none');
        $('#answer-0-0-title').val('');
      }else {
        $(add_answer_btns[0]).removeClass('disabled');
        $(remove_answer_btns[0]).removeClass('disabled');
        $('.field-answer-0-0-title').addClass('required');
        $('#answer-0-0-title').addClass('is-invalid');
        $('#answer-0-0-title').removeAttr('disabled');
        $('#answer-0-0-true_false').removeClass('d-none');
      }
    
  })
  }
  
  $(".dynamicform_wrapper").on("beforeInsert", function(e, item) {
    
  });
  
  
  
  $(".dynamicform_wrapper").on("afterInsert", function(e, item) {
    
      remove_answer_btns = $('.remove-answer');
      add_answer_btns = $('.add-answer');
      questions = $('.question-item');
      questions = Array.from(questions);
      $(item).find('input').removeAttr('disabled');
      $(item).find('input').removeClass('d-none');
      $(item).find('.remove-answer').removeClass('disabled');
      $(item).find('.add-answer').removeClass('disabled');
      if($(item).find('input').hasClass('form-check-input')){
        $(item).find('input').prop('checked', false);
      }
      
  
      for( let i = 0; i < questions.length; i++){
        item = '#question-' + i + '-type_id';
        $(item).on('change', function(){
            if ($(this).val() == 4) {
              for( let j = 1; j <= 9; j++){
                let answer = $('.field-answer-' + i + '-' + j + '-title');
                let a_item = answer.parents('.answer-item');
                a_item.detach();
              }
              
              $(questions[i]).find('.remove-answer').addClass('disabled');
              $(questions[i]).find('.add-answer').addClass('disabled');
              $('.field-answer-'+i+'-0-title').removeClass('required');
              $('#answer-'+i+'-0-title').removeClass('is-invalid');
              $('#answer-'+i+'-0-title').attr('disabled', '');
              $('#answer-'+i+'-0-true_false').addClass('d-none');
              $('#answer-'+i+'-0-title').val('');
            }else {
              $(questions[i]).find('.remove-answer').removeClass('disabled');
              $(questions[i]).find('.add-answer').removeClass('disabled');
              $('.field-answer-'+i+'-0-title').addClass('required');
              $('#answer-'+i+'-0-title').addClass('is-invalid');
              $('#answer-'+i+'-0-title').removeAttr('disabled');
              $('#answer-'+i+'-0-true_false').removeClass('d-none');
  
            }
        })
      }
      
      
      
      $(".dynamicform_inner").on("afterInsert", function(e, item) {
       
        $(item).find('.remove-answer').removeClass('disabled');
        $(item).find('.add-answer').removeClass('disabled');
  
        $(item).find('input,textarea,select').each(function(index,element){
          if($(element).attr('type') != 'checkbox'){
            $(element).val('');
          }
          $(element).removeAttr('disabled');
          $(element).removeClass('d-none');
          $(element).prop('checked', false);
      
          $(element).removeClass('is-valid');
            
        });
      });
  });
  
  $(".dynamicform_wrapper").on("beforeDelete", function(e, item) {
    if (! confirm("Are you sure you want to delete this item?")) {
        return false;
    }
    return true;
  });
  
  $(".dynamicform_wrapper").on("afterDelete", function(e) {
    console.log("Deleted item!");
  });
  
  $(".dynamicform_wrapper").on("limitReached", function(e, item) {
    alert("Limit reached");
  });
  
  
  
  $(".dynamicform_inner").on("afterInsert", function(e, item) {
      $(item).find('input,textarea,select').each(function(index,element){
        if($(element).attr('type') != 'checkbox'){
          $(element).val('');
        }
  
        
        $(element).removeAttr('disabled');
        $(element).removeClass('d-none');
        $(element).prop('checked', false);
          
        //  if($(element).attr('type') == 'checkbox'){
        //     $(element).removeAttr("checked");
        //     $(element).removeClass('is-valid');
        //     $(element).prop('checked', false);
        //   }
    
          $(element).removeClass('is-valid');
          let numOfQuestion = element.id.split('-')[1];
         
      });
    });
  
  });
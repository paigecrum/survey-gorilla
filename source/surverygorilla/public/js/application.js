$(document).ready(function() {
  $(document).on('submit', "form[name='create_survey_title']", function(event){
    event.preventDefault();
    console.log('good');

    var url = $(this).attr("action");
    var data = $(this).serialize();
    var title = $('[name="survey_title"]').val();

    $.post(url, data, function(response){
      $('.new_question').html(response);
      $('#submit_title_form').hide();
      $('#survey_title').html(title);

    }); // end of post

  }); // end form on submit title

  $(document).on('submit',"form[name='question']", function(event){
    event.preventDefault();
    console.log('yes');

    var url = $(this).attr("action");
    var data = $(this).serialize();
    // var question = $('[name="question"]').val();

    $.post(url, data, function(response){
      $('#existing_questions').html(response);
      $("form[name='question']").find("input[type=text], textarea").val("");

    }); // end of post

  }); // end form on submit question

  $(document).on('submit',"form[name='question_response']", function(event){
    event.preventDefault();
    console.log('yes');

    var url = $(this).attr("action");
    var data = $(this).serialize();
  //   var questionResponse = $('[name="question_response"]').val();

    $.post(url, data, function(response){
      $('#existing_questions').html(response);
      $("form[name='question_response']").find("input[type=text], textarea").val("");

    });
  });

});  // end doc ready

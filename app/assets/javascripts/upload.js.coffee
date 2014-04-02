
$(document).ready ->
  dropbox$ = $('#post_body')[0]
  #dropbox$.addEventListener "dragenter", dragEnter, false
  new Upload dropbox$

 class Upload

   constructor: (dropBox) ->
     event = ["dragenter", "dragexit", "dragover", "drop"]
     dropBox.addEventListener(ev, @handler, false) for ev in event
     this

   enter= (event) ->
      console.log 'drag' + event

   handler: (event) ->
      console.log 'drag'
      files = event.dataTransfer.files
      if files.length == 1
        upload_file(files[0])
        $('#loader').css( 'left': event.clientX, 'top': event.clientY, 'z-index': 1000 ).show()

      event.stopPropagation()
      event.preventDefault()

   upload_file= (file) ->
      console.log file.name
      @file_name = file.name
      reader =  new FileReader()
      reader.onload = handleReaderLoad
      reader.readAsDataURL(file)


   handleReaderLoad= (event) =>
    file = event.target.result
    bucket = $('#new_post').data "bucket"
    text_area$ =  $('#post_body')
    try
      format = file.match(/data\:image\/.+;/)[0].split("/")[1].split(";")[0]
      file_base64 =  file.match(/,(.*)$/)[1]
      data =
        type: 'POST'
        url: "/posts/add_image"
        autoUpload: true
        success: (response) ->
          text_area$.val("#{text_area$.val()}!#{response.filename}!")
          $('#loader').hide()
        data:
          image: file_base64
          format_image: format
          authenticity_token: $('[name="authenticity_token"]')[0].value
       $.ajax data

      catch error
        alert "file extension is no valid"


  var data = [
    { 
      "text": "Тип мероприятия", 
      "children" : [
        {
            "id": 1,
            "text": "Обучение"
        },
        {
            "id": 2,
            "text": "Событие"
        }
      ]
    },
    { 
      "text": "Сообщество", 
      "children" : [
        {
            "id": 3,
            "text": "QA"
        },
        {
            "id": 4,
            "text": "Ruby"
        }
      ]
    }
  ];
$( document ).ready(function() {
    $('#event_tag_list').select2({data: data, placeholder: "Выберите необходимые тэги", allowClear: true, tags: true, tokenSeparators: [',', ' '], multiple: true})
  });
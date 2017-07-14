document.addEventListener "turbolinks:load", ->
  $('.js-customer-search-field').on 'input', ->
    empty_search_results()
    query = $(this).val()

    unless query == ''
      $.get(
        url: '/search/customers?query=' + query
      ).done (result) ->
        result.forEach (customer) ->
          $('.js-search-result').append result_field_for_customer(customer)

  $('.js-search-result').on("click", "tr", ->
    empty_search_results()
    element = $(this)
    name = element.children('[name]').html()

    $('.js-customer-search-field').val(name)
  )

empty_search_results = ->
  $('.js-search-result').empty()

result_field_for_customer = (customer) ->
  name_column = "<td name>" + customer['first_name'] + ' ' + customer['last_name'] + "</td>"
  address_column = "<td>" + customer['address'] + "</td>"

  "<tr result_type='customer'>" + name_column + address_column + "</tr>"

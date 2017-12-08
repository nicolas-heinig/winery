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

  $('.js-wine-search-field').on 'input', ->
    empty_search_results()
    query = $(this).val()

    unless query == ' '
      $.get(
        url: '/search/wines?query=' + query
      ).done (result) ->
        result.forEach (wine) ->
          $('.js-search-result').append result_field_for_wine(wine)

  $('.js-search-result').on("click", "tr", ->
    empty_search_results()
    element = $(this)
    name = element.children('[name]').html()

    if element.attr('result_type') == 'customer'
      $('.js-customer-search-field').val(name)
    else
      $('.js-wine-search-field').val(name)
  )

empty_search_results = ->
  $('.js-search-result').empty()

result_field_for_customer = (customer) ->
  name_column = "<td name>" + customer['first_name'] + ' ' + customer['last_name'] + "</td>"
  address_column = "<td>" + customer['address'] + "</td>"

  "<tr result_type='customer'>" + name_column + address_column + "</tr>"

result_field_for_wine = (wine) ->
  name_column = "<td name>" + wine['name'] + "</td>"
  type_column = "<td>" + wine['wine_type'] + "</td>"
  year_column = "<td>" + wine['year'] + "</td>"

  "<tr result_type='wine'>" + name_column + type_column + year_column + "</tr>"

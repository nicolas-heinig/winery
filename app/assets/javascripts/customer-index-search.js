document.addEventListener("turbolinks:load", () => {
  $('.js-customer-index-search').on("input", () => {
    $('tbody').empty()

    let query = $('.js-customer-index-search').val()
    
    if (!(query == '')) {
      $.get({
        url: '/search/customers?query=' + query
      }).done((result) => {
        result.forEach((customer) => {
          $('tbody').append(result_field_for_customer(customer))
        })
      })   
    } 
  })
})

const result_field_for_customer = (customer) => {
  return("<tr>" +
    "<td>" + customer.id + "</td>" +
    "<td>" + customer.first_name + "</td>" +
    "<td>" + customer.last_name + "</td>" +
    "<td>" + customer.address + "</td>" +
    "<td>" + customer.phone + "</td>" +
    links_for(customer) +
  "</tr>")
}

const links_for = (customer) => {
  const id = customer.id

  return(`<td class="hidden-sm hidden-xs">
      <a href="/customers/${id}">
        <span class="glyphicon glyphicon-eye-open"></span> Anzeigen
      </a>
    </td>
    <td class="hidden-sm hidden-xs">
      <a href="/customers/${id}/edit">
        <span class="glyphicon glyphicon-pencil"></span> Bearbeiten
      </a> 
    </td> 
    <td class="hidden-sm hidden-xs"> 
      <a data-confirm="Bist du sicher?" rel="nofollow" data-method="delete" href="/customers/${id}">
        <span class="glyphicon glyphicon-trash"></span> Löschen
      </a> 
    </td>
    <td class="visible-sm visible-xs">
      <div class="dropdown">
        <a aria-haspopup="true" class="dropdown-toggle" data-toggle="dropdown">
          <span class="caret"></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-right">
          <li> 
            <a href="/customers/${id}">
              <span class="glyphicon glyphicon-eye-open"></span> Anzeigen
            </a>
          </li> 
          <li>
            <a href="/customers/${id}/edit">
              <span class="glyphicon glyphicon-pencil"></span> Bearbeiten
            </a>
          </li>
          <li>
            <a data-confirm="Bist du sicher?" rel="nofollow" data-method="delete" href="/customers/${id}"> 
              <span class="glyphicon glyphicon-trash"></span> Löschen
            </a>
          </li>
        </ul> 
      </div>
    </td>`)
}
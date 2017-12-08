document.addEventListener("turbolinks:load", () => {
  $('.js-wine-index-search').on("input", () => {
    $('tbody').empty()

    let query = $('.js-wine-index-search').val()
    
    if (!(query == '')) {
      $.get({
        url: '/search/wines?query=' + query
      }).done((result) => {
        result.forEach((wine) => {
          $('tbody').append(result_field_for_wine(wine))
        })
      })   
    } 
  })
})

const result_field_for_wine = (wine) => {
  return("<tr>" +
    "<td>" + wine.id + "</td>" +
    "<td>" + wine.name + "</td>" +
    "<td>" + wine.volume + "</td>" +
    "<td>" + price(wine.bottle_price) + "</td>" +
    "<td>" + price(wine.box_price) + "</td>" +
    "<td>" + wine.year + "</td>" +
    "<td>" + wine.from + "</td>" +
    "<td>" + wine.wine_type + "</td>" +
    links_for_wine(wine) +
  "</tr>")
}

const links_for_wine = (wine) => {
  const id = wine.id

  return(`<td class="hidden-sm hidden-xs">
      <a href="/wines/${id}">
        <span class="glyphicon glyphicon-eye-open"></span> Anzeigen
      </a>
    </td>
    <td class="hidden-sm hidden-xs">
      <a href="/wines/${id}/edit">
        <span class="glyphicon glyphicon-pencil"></span> Bearbeiten
      </a> 
    </td> 
    <td class="hidden-sm hidden-xs"> 
      <a data-confirm="Bist du sicher?" rel="nofollow" data-method="delete" href="/wines/${id}">
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
            <a href="/wines/${id}">
              <span class="glyphicon glyphicon-eye-open"></span> Anzeigen
            </a>
          </li> 
          <li>
            <a href="/wines/${id}/edit">
              <span class="glyphicon glyphicon-pencil"></span> Bearbeiten
            </a>
          </li>
          <li>
            <a data-confirm="Bist du sicher?" rel="nofollow" data-method="delete" href="/wines/${id}"> 
              <span class="glyphicon glyphicon-trash"></span> Löschen
            </a>
          </li>
        </ul> 
      </div>
    </td>`)
}

const price = (number) => {
  return(Math.round(number).toFixed(2).toString().replace('.', ',') + ' €')
}
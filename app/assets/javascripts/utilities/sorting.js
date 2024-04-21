document.addEventListener('turbolinks:load', function() {
    let sorted = document.querySelector('.sort-by-title')
    if (sorted) {
        sorted.addEventListener('click', sortRowsByTitle)
        console.log('.sort-by-title added click EventListener')
    }
})

function sortRowsByTitle() {
    let table = this.closest('table')
    let rows = table.querySelectorAll('tr') // NodeList

    let sortedRows = []
    for  (let i=1; i<rows.length-1; i++) {
        sortedRows.push([rows[i]])
    }

    
    // table.querySelectorAll('th.sort-by-title svg.octicon-arrow-up')[0]
    let arrow_up_icon = this.querySelector('.octicon-arrow-up')
    let arrow_dn_icon = this.querySelector('.octicon-arrow-down')
    if (arrow_up_icon.classList.contains('hide')) {
    // if (arrow_up_icon.classList.contains('hide') && arrow_dn_icon.classList.contains('hide')) {
    // } else if (arrow_up_icon.classList.contains('hide') && !arrow_dn_icon.classList.contains('hide')) {
        sortedRows.sort(compareRowsAsc)
        arrow_up_icon.classList.remove('hide')
        arrow_dn_icon.classList.add('hide')
    } else {
    // } else if (!arrow_up_icon.classList.contains('hide') && arrow_dn_icon.classList.contains('hide')) {
        sortedRows.sort(compareRowsDesc)
        arrow_up_icon.classList.add('hide')
        arrow_dn_icon.classList.remove('hide')
    }


    let sortedTable = document.createElement('table')
    sortedTable.classList.add('table')
    sortedTable.appendChild(rows[0]) // Captions from unsortedTable
    for (let i = 0; i<sortedRows.length; i++) {
        sortedTable.appendChild(sortedRows[i][0]) // Row
    }
    sortedTable.appendChild(rows[rows.length-1]) // Totals from unsortedTable

    table.parentNode.replaceChild(sortedTable, table)
}

function compareRowsAsc(row1, row2) {
    let testTitle1 = row1[0].childNodes[11].textContent
    let testTitle2 = row2[0].childNodes[11].textContent

    if (testTitle1 > testTitle2) { return 1 }
    if (testTitle2 > testTitle1) { return -1 }
    return 0
}

function compareRowsDesc(row1, row2) {
    let testTitle1 = row1[0].childNodes[11].textContent
    let testTitle2 = row2[0].childNodes[11].textContent

    if (testTitle2 > testTitle1) { return 1 }
    if (testTitle1 > testTitle2) { return -1 }
    return 0
}

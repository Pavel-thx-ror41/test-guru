const SORT_COLUMN_CLASS_MARKER = 'sort-by-text'

document.addEventListener('turbolinks:load', function() {
    let sortedTh = document.querySelector(`.${SORT_COLUMN_CLASS_MARKER}`)
    if (sortedTh) {
        sortedTh.addEventListener('click', sortTableRowsByText)
    }
})

function sortTableRowsByText() {
    let table = this.closest('table')
    let rows = table.querySelectorAll('tr') // nodeList
    let arrow_up_icon = this.querySelector('.octicon-arrow-up')
    let arrow_dn_icon = this.querySelector('.octicon-arrow-down')

    let sortedRows = []
    for  (let i=1; i<rows.length-1; i++) {
        sortedRows.push([rows[i]])
    }

    if (arrow_up_icon.classList.contains('hide')) {
        sortedRows.sort(compareRowsAsc)
        arrow_up_icon.classList.remove('hide')
        arrow_dn_icon.classList.add('hide')
    } else {
        sortedRows.sort(compareRowsDesc)
        arrow_up_icon.classList.add('hide')
        arrow_dn_icon.classList.remove('hide')
    }

    let sortedTable = document.createElement('table')
    sortedTable.classList.add('table')
    sortedTable.appendChild(rows[0])              // 1st row - table captions
    for (let i = 0; i<sortedRows.length; i++) {
        sortedTable.appendChild(sortedRows[i][0]) // sorted rows
    }
    sortedTable.appendChild(rows[rows.length-1])  // last row - table totals

    table.parentNode.replaceChild(sortedTable, table)
}

function compareRowsAsc(row1, row2) {
    let testTitle1 = sortColumnComparedText(row1[0])
    let testTitle2 = sortColumnComparedText(row2[0])

    if (testTitle1 > testTitle2) { return 1 }
    if (testTitle2 > testTitle1) { return -1 }
    return 0
}

function compareRowsDesc(row1, row2) {
    let testTitle1 = sortColumnComparedText(row1[0])
    let testTitle2 = sortColumnComparedText(row2[0])

    if (testTitle2 > testTitle1) { return 1 }
    if (testTitle1 > testTitle2) { return -1 }
    return 0
}

function sortColumnComparedText(row) {
    return Array.prototype.slice.call(row.childNodes, 0).find(isSortColumn).textContent
}

function isSortColumn(column) {
    return ((column.nodeType === 1) && (column.classList.contains(SORT_COLUMN_CLASS_MARKER)))
}

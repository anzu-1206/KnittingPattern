$(document).on('turbo:load', function() {

    let patternData = []; 
    let currentRow = 0;
    let currentCell = 0;
    let scale = 1.0;

    const $canvas = $('#knitting-canvas');
    const $viewport = $('#canvas-viewport');

    $('#start-btn').on('click', function() {
        const count = prompt("作り目の数は？（半角数字）", "20");
        if (count && !isNaN(count)) {
            const num = parseInt(count);
            patternData = [Array.from({ length: num }, () => ({ color: null }))];
            currentRow = 0;
            currentCell = 0;
            scale = 1.0;
            updateTransform();
            renderCanvas();
        }
    });


    function renderCanvas() {
        $('#row-counter').text('段目: ' + (currentRow + 1));
        $canvas.empty();

        patternData.forEach((row, rIdx) => {
            const $rowDiv = $('<div class="knit-row"></div>');

            row.forEach((cell, cIdx) => {
                const $cellDiv = $('<div class="cell"></div>');
                
                const currentRatio = $('#gauge-ratio').val() || 1.0;
                $cellDiv.css('height', (25 * currentRatio) + 'px');
                
                $cellDiv.attr('data-r', rIdx);
                $cellDiv.attr('data-c', cIdx);

                if (cell.color) {
                    $cellDiv.css('background-color', cell.color);
                }

                if (rIdx === currentRow && cIdx === currentCell) {
                    $cellDiv.addClass('active');
                }
                
                $cellDiv.on('click', function(e) {
                    e.stopPropagation();
                    if (e.shiftKey) {
                        const minR = Math.min(currentRow, rIdx);
                        const maxR = Math.max(currentRow, rIdx);
                        const minC = Math.min(currentCell, cIdx);
                        const maxC = Math.max(currentCell, cIdx);

                        $('.cell').removeClass('selected');
                        $('.cell').each(function() {
                            const r = parseInt($(this).attr('data-r'));
                            const c = parseInt($(this).attr('data-c'));
                            if (r >= minR && r <= maxR && c >= minC && c <= maxC) {
                                $(this).addClass('selected');
                            }
                        });
                    } else {
                        $('.cell').removeClass('selected');
                        currentRow = rIdx;
                        currentCell = cIdx;
                        renderCanvas();
                    }
                });

                $rowDiv.append($cellDiv);
            });
            $canvas.append($rowDiv);
        });
    }


    $('#confirm-color-btn').on('click', function() {
        const newColor = $('#color-picker').val();
        const $btn = $('<button>')
            .addClass('color-item')
            .css('background-color', newColor)
            .attr('data-color', newColor);
        $('#recent-colors').append($btn);
    });


    $(document).on('click', '.color-item', function() {
        $('.color-item').removeClass('selected');
        $(this).addClass('selected');

        const color = $(this).data('color');
        if (!color) return;
        if (patternData.length === 0) return;

        const $selectedCells = $('.cell.selected');
        if ($selectedCells.length > 0) {
            $selectedCells.each(function() {
                const r = parseInt($(this).attr('data-r'));
                const c = parseInt($(this).attr('data-c'));
                patternData[r][c].color = color;
            });
            $('.cell').removeClass('selected');
            renderCanvas();
        } else {
            patternData[currentRow][currentCell].color = color;
            if (currentCell < patternData[currentRow].length - 1) {
                currentCell++;
            }
            renderCanvas();
        }
    });


    $('#undo-btn').on('click', function() {
        if (patternData.length === 0) return;
        if (!patternData[currentRow][currentCell].color) {
            if (currentCell > 0) currentCell--;
            else if (currentRow > 0) { currentRow--; currentCell = patternData[currentRow].length - 1; }
        }
        patternData[currentRow][currentCell].color = null;
        renderCanvas();
    });

    $('#next-row-btn').on('click', function() {
        if (patternData.length === 0) return;
        const lastRow = patternData[patternData.length - 1];
        const newRow = Array.from({ length: lastRow.length }, () => ({ color: null }));
        patternData.push(newRow);
        currentRow = patternData.length - 1;
        currentCell = 0;
        renderCanvas();
    });


    $('#save-btn').on('click', function() {
        if (patternData.length === 0) return;
        const title = prompt("タイトルを入力", "わたしの編み図");
        if (!title) return;
        
        const width = patternData[0].length;
        const height = patternData.length;

        $.ajax({
            url: '/patterns',
            method: 'POST',
            data: { 
                pattern: { 
                    title: title, 
                    grid_width: width, 
                    grid_height: height, 
                    pattern_data: JSON.stringify(patternData),
                    is_public: false
                } 
            },
            headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },

            success: function(response) { 
                alert("保存しました");

                if (response.redirect_url) {
                    window.location.href = response.redirect_url;
                } else {
                    window.location.href = '/patterns';
                }
            },
            
            error: function(xhr) { 
                const response = xhr.responseJSON;
                if (response && response.errors) {
                    alert("保存失敗: " + response.errors.join(", "));
                } else {
                    alert("保存失敗: サーバーエラーが発生しました");
                }
            }
        });
    });


    $('#reset-btn').on('click', function() {
        if (confirm("リセットしますか？")) {
            patternData = [];
            currentRow = 0;
            currentCell = 0;
            $('#row-counter').text('段目: 0');
            $canvas.empty();
        }
    });


    function updateTransform() {
        $canvas.css('transform', `scale(${scale})`);
        $('#zoom-level').text(Math.round(scale * 100) + '%');
    }
    $('#zoom-in-btn').on('click', function() { if (scale < 3.0) { scale += 0.1; updateTransform(); } });
    $('#zoom-out-btn').on('click', function() { if (scale > 0.2) { scale -= 0.1; updateTransform(); } });
    $('#reset-view-btn').on('click', function() { scale = 1.0; updateTransform(); });


    $('#clear-history-btn').on('click', function() {
        if ($('#recent-colors').children().length === 0) return;
        if (confirm("履歴を削除しますか？")) $('#recent-colors').empty();
    });
    $(document).on('contextmenu', '#recent-colors .color-item', function(e) {
        e.preventDefault();
        if(confirm('この色を削除しますか？')) $(this).remove();
        return false;
    });


    $('.tab-btn').on('click', function() {
        $('.tab-btn').removeClass('active');
        $(this).addClass('active');
        $('.tab-content').removeClass('active');
        const targetId = $(this).data('target');
        $(targetId).addClass('active');
    });


    $('#import-btn').on('click', function() { $('#import-image').click(); });

    $('#import-image').on('change', function(e) {
        const file = e.target.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = function(event) {
            const img = new Image();
            img.onload = function() {
                const inputWidth = prompt("横幅（目数）を入力", "50");
                if (!inputWidth || isNaN(inputWidth)) return;

                const newCols = parseInt(inputWidth);
                const aspectRatio = img.height / img.width;
                const newRows = Math.floor(newCols * aspectRatio);

                if (!confirm(`横${newCols}目 × 縦${newRows}段 で作成しますか？\n（画像の色をそのまま使います）`)) {
                    $('#import-image').val('');
                    return;
                }

                const tempCanvas = document.createElement('canvas');
                const ctx = tempCanvas.getContext('2d');
                tempCanvas.width = newCols;
                tempCanvas.height = newRows;

                ctx.drawImage(img, 0, 0, newCols, newRows);
                const imageData = ctx.getImageData(0, 0, newCols, newRows).data;

                patternData = [];
                for (let r = 0; r < newRows; r++) {
                    const rowData = [];
                    for(let c = 0; c < newCols; c++) {
                        const pixelIndex = ((r) * newCols + c) * 4;
                        const alpha = imageData[pixelIndex + 3];
                        let hex = null;

                        if (alpha > 128) {
                            let rVal = imageData[pixelIndex];
                            let gVal = imageData[pixelIndex + 1];
                            let bVal = imageData[pixelIndex + 2];

                            if (rVal < 180 && gVal < 180 && bVal < 180) {
                                rVal = 0;
                                gVal = 0;
                                bVal = 0;
                            }

                            hex = "#" + ((1 << 24) + (rVal << 16) + (gVal << 8) + bVal).toString(16).slice(1);
                        }
                        rowData.push({ color: hex });
                    }
                    patternData.unshift(rowData); 
                }

                currentRow = 0;
                currentCell = 0;
                renderCanvas();
                $('#import-image').val('');
                scale = 1.0;
                updateTransform();
            };
            img.src = event.target.result;
        };
        reader.readAsDataURL(file);
    });


    $('#gauge-ratio').on('input', function() {
        const ratio = $(this).val();
        $('.cell').css('height', (25 * ratio) + 'px');
    });


    $(document).on('keydown', function(e) {
        if (patternData.length === 0) return;
        if ($(e.target).is('input, textarea')) return;
        let moved = false;
        switch (e.key) {
            case 'ArrowLeft': if (currentCell > 0) { currentCell--; moved = true; } break;
            case 'ArrowRight': if (currentCell < patternData[currentRow].length - 1) { currentCell++; moved = true; } break;
            case 'ArrowUp': 
                if (currentRow < patternData.length - 1) {
                    currentRow++;
                    if (currentCell >= patternData[currentRow].length) currentCell = patternData[currentRow].length - 1;
                    moved = true;
                } break;
            case 'ArrowDown': 
                if (currentRow > 0) {
                    currentRow--;
                    if (currentCell >= patternData[currentRow].length) currentCell = patternData[currentRow].length - 1;
                    moved = true;
                } break;
        }
        if (moved) { e.preventDefault(); renderCanvas(); }
    });
});
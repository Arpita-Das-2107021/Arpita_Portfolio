function initNoteFeatures() {
    const modal = document.getElementById('noteModal');
    const openNoteBtn = document.getElementById('openNoteBtn');
    const cancelModalBtn = document.getElementById('cancelModalBtn');

    if (openNoteBtn && modal) {
        openNoteBtn.onclick = () => {
            modal.classList.add('show');
        };
    }
    if (cancelModalBtn && modal) {
        cancelModalBtn.onclick = () => {
            modal.classList.remove('show');
        };
    }

    // --- Drawing logic ---
    const canvas = document.getElementById('drawCanvas');
    if (!canvas) return; // Defensive: if UpdatePanel hasn't rendered yet

    const ctx = canvas.getContext('2d');
    let drawing = false;
    let lastX = 0, lastY = 0;
    let brushColor = "#34c759";
    let brushSize = 4;
    let mode = "pen"; // or "eraser"

    // Undo/redo stacks
    let undoStack = [];
    let redoStack = [];

    function saveState(stack, keepRedo = false) {
        if (!keepRedo) redoStack = [];
        stack.push(canvas.toDataURL());
        if (stack.length > 20) stack.shift();
    }
    function restoreState(stackFrom, stackTo) {
        if (stackFrom.length === 0) return;
        stackTo.push(canvas.toDataURL());
        const imgData = stackFrom.pop();
        let img = new window.Image();
        img.src = imgData;
        img.onload = () => {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.drawImage(img, 0, 0);
        };
    }

    // Drawing events
    canvas.addEventListener('mousedown', e => {
        drawing = true;
        [lastX, lastY] = [e.offsetX, e.offsetY];
        ctx.beginPath();
        ctx.moveTo(lastX, lastY);
        saveState(undoStack);
    });
    canvas.addEventListener('mousemove', e => {
        if (!drawing) return;
        ctx.lineTo(e.offsetX, e.offsetY);
        ctx.strokeStyle = brushColor;
        ctx.lineWidth = brushSize;
        ctx.lineCap = 'round';
        ctx.lineJoin = 'round';
        ctx.globalCompositeOperation = (mode === "pen") ? "source-over" : "destination-out";
        ctx.stroke();
        [lastX, lastY] = [e.offsetX, e.offsetY];
    });
    canvas.addEventListener('mouseup', () => {
        drawing = false;
        ctx.closePath();
        ctx.globalCompositeOperation = "source-over";
    });
    canvas.addEventListener('mouseleave', () => {
        drawing = false;
        ctx.closePath();
        ctx.globalCompositeOperation = "source-over";
    });

    // --- Toolbar controls ---
    document.querySelectorAll('.color-btn').forEach(btn => {
        btn.addEventListener('click', function () {
            //console.log('Color buttons changed:', this.dataset.color);
            document.querySelectorAll('.color-btn').forEach(b => b.classList.remove('selected'));
            this.classList.add('selected');
            brushColor = this.dataset.color;
            mode = "pen";
            penBtn.classList.add('active');
            eraserBtn.classList.remove('active');
        });
    });
    // Handle custom color input separately
    document.getElementById('colorPicker').addEventListener('input', function () {
        //console.log('Color picker changed:', this.value);
        document.querySelectorAll('.color-btn').forEach(b => b.classList.remove('selected')); // Remove any highlight
        brushColor = this.value; // Use picked color
        mode = "pen";
        penBtn.classList.add('active');
        eraserBtn.classList.remove('active');
    });

    const penBtn = document.getElementById('penBtn');
    const eraserBtn = document.getElementById('eraserBtn');
    penBtn.onclick = () => {
        mode = "pen";
        penBtn.classList.add('active');
        eraserBtn.classList.remove('active');
    };
    eraserBtn.onclick = () => {
        mode = "eraser";
        penBtn.classList.remove('active');
        eraserBtn.classList.add('active');
    };

    const brushSizeInput = document.getElementById('brushSize');
    const brushDisplay = document.getElementById('brushDisplay');
    brushSizeInput.addEventListener('input', e => {
        brushSize = e.target.value;
        brushDisplay.textContent = brushSize;
    });
    brushDisplay.textContent = brushSizeInput.value;

    document.getElementById('undoBtn').onclick = () => restoreState(undoStack, redoStack);
    document.getElementById('redoBtn').onclick = () => restoreState(redoStack, undoStack);
    document.getElementById('clearBtn').onclick = () => {
        saveState(undoStack);
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    };

    // --- Note creation ---
    const notesBoard = document.getElementById('notesBoard');
    const noteCount = document.getElementById('noteCount');

    const drawingInput = document.getElementById('drawingData');
    const aspBtn = document.querySelector("input[id$='btnSubmit']"); // ASP.NET renames ID

    if (aspBtn && drawingInput) {
        aspBtn.addEventListener('click', function () {
            const dataUrl = canvas.toDataURL('image/png');
            drawingInput.value = dataUrl;
        });
    }

    // --- Initialize ---
    document.querySelector('.color-btn[data-color="#34c759"]').classList.add('selected');
}

// Initial page load
document.addEventListener('DOMContentLoaded', initNoteFeatures);

// After every UpdatePanel async postback
Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
    initNoteFeatures();
});
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Note.ascx.cs" Inherits="finalPortfolio.Note" %>
<!-- canvas-notes -->

 <section class="canvas">
     <asp:UpdatePanel ID="up2" runat="server">
         <ContentTemplate>
             <!-- canvas-notes -->
             <div class="container">
                 <div class="topbar">
                     <span class="icon"><i class="fa-solid fa-note-sticky"></i></span>
                     <asp:Label ID="noteCount" runat="server" CssClass="counter" Text="0" />
                     <button id="openNoteBtn" type="button">+ Leave a note</button>
                 </div>

                 <div class="notes-board">
                     <asp:Literal ID="notesBoard" runat="server" Mode="PassThrough" />
                 </div>


                 <!-- Modal for leaving a note -->
                 <div class="modal" id="noteModal">
                     <div class="modal-content">
                         <div class="draw-toolbar">
                             <div class="color-palette">
                                 <input type="color" id="colorPicker" class="color-btn" />
                                 <button type="button" class="color-btn" style="background: #ff3b30" data-color="#ff3b30"></button>
                                 <button type="button" class="color-btn" style="background: #ffd60a" data-color="#ffd60a"></button>
                                 <button type="button" class="color-btn" style="background: #34c759" data-color="#34c759"></button>
                                 <button type="button" class="color-btn" style="background: #007aff" data-color="#007aff"></button>
                                 <button type="button" class="color-btn" style="background: #af52de" data-color="#af52de"></button>
                                 <button type="button" class="color-btn" style="background: #fff" data-color="#fff"></button>
                                 <button type="button" class="color-btn" style="background: #222" data-color="#222"></button>
                             </div>
                             <button id="penBtn" type="button" class="tool-btn active" title="Pen">
                                 <i
                                     class="fa-solid fa-pen-to-square"></i>
                             </button>
                             <button id="eraserBtn" type="button" class="tool-btn" title="Eraser">
                                 <i
                                     class="fa-solid fa-eraser"></i>
                             </button>
                             <input type="range" id="brushSize" min="2" max="20" value="4">
                             <span id="brushDisplay">4</span>
                             <button id="undoBtn" type="button" class="tool-btn" title="Undo">
                                 <i
                                     class="fa-solid fa-rotate-left"></i>
                             </button>
                             <button id="redoBtn" type="button" class="tool-btn" title="Redo">
                                 <i
                                     class="fa-solid fa-rotate-right"></i>
                             </button>
                             <button id="clearBtn" type="button" class="tool-btn" title="Cancel"><i class="fa-solid fa-trash"></i></button>
                         </div>

                         <canvas id="drawCanvas" width="280" height="280"></canvas>

                         <div id="noteForm">

                             <input type="text" id="noteName" name="noteName" maxlength="18" placeholder="Your name">
                             <input type="text" id="noteMsg" name="noteMsg" maxlength="40" placeholder="Your message">
                             <input type="hidden" id="drawingData" name="drawingData" />
                             <div class="form-btns">
                                 <button type="button" id="cancelModalBtn" class="cancel-btn">Cancel</button>
                                 <asp:Button ID="btnSubmit" runat="server" Text="Leave Note" OnClick="noteForm_Submit" CssClass="leave-btn"
                                     Style="background: var(--cancel-btn-hover); color: var(--leave-btn-text); border: 2px solid var(--leave-btn-border); border-radius: 8px; padding: 7px 14px; font-size: 15px; cursor: pointer;"
                                     onmouseover="this.style.backgroundColor='transparent'; 
                             this.style.border='2px solid gray';"
                                     onmouseout="this.style.backgroundColor='var(--cancel-btn-hover)';" />
                             </div>

                         </div>

                     </div>
                 </div>
             </div>
         </ContentTemplate>
         <Triggers>
             <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
         </Triggers>
     </asp:UpdatePanel>
 </section>

 <footer class="footer">
     <p>&copy; 2025 Arpita Das. All rights reserved.</p>
 </footer>
 <script type="text/javascript" src="note.js"></script>
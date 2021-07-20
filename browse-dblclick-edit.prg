//	Author: Ralph del Castillo
//	Fecha.: 07/11/20
//	-------------------------------------------
//      {% LoadHrb( 'lib/tweb/tweb.hrb' ) %}

#include {% TWebInclude() %}

function main()

    local o, oWeb, oCol, oBrw
        local aRows := LoadData()

        DEFINE WEB oWeb TITLE 'Test Browse' ICON 'images/favicon.ico' TABLES INIT

        DEFINE FORM o

                HTML o INLINE '<h3>Test Browse - click edit</h3><hr>'

        INIT FORM o

                ROW o

                        COL o GRID 12

                                DEFINE BROWSE oBrw ID 'ringo' HEIGHT 400 DBLCLICK 'editRow' OF o

                                        ADD oCol TO oBrw ID 'first'     HEADER 'First'  ALIGN 'right'
                                        ADD oCol TO oBrw ID 'last'              HEADER 'Last'   SORT
                                        ADD oCol TO oBrw ID 'age'               HEADER 'Age'    WIDTH 70

                                INIT BROWSE oBrw DATA aRows

                        ENDCOL o

                ENDROW o

                HTML o

                    <!-- Modal -->
                    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="pickTitle" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered modal-lg modal-sm"  role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="pickTitle">Registro</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <div class="modal-body">

                 ENDTEXT
                              ROWGROUP o
								  GET oGet ID 'edit-first' VALUE '' LABEL 'First' READONLY OF o
								  GET oGet ID 'edit-last' VALUE '' LABEL 'Last' READONLY OF o
                              ENDROW o
                              ROWGROUP o
								  SAY VALUE 'Age' OF o
								  GETNUMBER oGet ID 'edit-age' VALUE '' OF o
                              ENDROW o
                 HTML o

                          </div>
                          <div class="modal-footer">
                            <button type="button" id="btnClose" class="btn btn-secondary btn-sm" data-dismiss="modal">Cerrar</button>
                            <button type="button" id="btnAccept" class="btn btn-primary btn-sm">Aceptar</button>
                          </div>
                        </div>
                      </div>
                    </div>

                    <script>

                            function editRow(e,row) {
                                     console.log("row",row)
                                     $("#editModal").modal({
                                            backdrop: 'static',
                                            keyboard: false,
                                            show: true
                                     });
                                     $("#edit-first").val(row.first)
                                     $("#edit-last").val(row.last)
                                     $("#edit-age").val(row.age)
                            }

                            $( '#btnAccept' ).click(function() {
                                var age = $('#edit-age').val()
                                $("#editModal").modal("hide")
                                  MsgInfo( "bye "+age )
                                  //MsgServer( 'mysave.prg', age )

                            });

                    </script>

                ENDTEXT

        END FORM o

retu nil

{% LoadFile( 'loaddata.prg' ) %}
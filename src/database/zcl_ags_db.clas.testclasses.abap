
CLASS ltcl_test DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS FINAL.

  PRIVATE SECTION.
    METHODS:
      setup,
      simple FOR TESTING
        RAISING zcx_ags_error.

ENDCLASS.       "ltcl_Test

CLASS ltcl_test IMPLEMENTATION.

  METHOD setup.

    zcl_ags_db=>set_fake( ).

  ENDMETHOD.

  METHOD simple.

    CONSTANTS: lc_name TYPE zags_repos-name VALUE 'TESTBLAH'.

    DATA: lv_repo TYPE zags_repo ##NEEDED.


    zcl_ags_repo=>create(
      iv_name        = lc_name
      iv_description = 'testblah' ).

* nothing should hit the database
    SELECT SINGLE repo FROM zags_repos INTO lv_repo
      WHERE name = lc_name ##WARN_OK.                     "#EC CI_SUBRC
    cl_abap_unit_assert=>assert_subrc( exp = 4 ).

* but it should still be accessible via memory
    zcl_ags_repo=>get_instance( lc_name ).

  ENDMETHOD.

ENDCLASS.

<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
  <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<!-- End of HtmlHeader.php -->

<!-- Start of Title and Meta -->
  <title>ORACLE-BASE - DBA Scripts for Oracle 10g, 9i and 8i</title>
  <meta name="description" content="ORACLE-BASE - DBA Scripts for Oracle 10g, 9i and 8i" />
  <meta name="keywords" content="oracle, dba, scripts, 10g, 9i, 8i, articles, certification" />
  <meta name="robots" content="index, follow" />
<!-- End of Title and Meta -->

<!-- Start of PageHeader.php -->
  <link rel="stylesheet" type="text/css" title="Default" href="http://www.oracle-base.com/css/Default.css" />
  <link rel="alternate stylesheet" type="text/css" title="UnderlinedLinks" href="http://www.oracle-base.com/css/UnderlinedLinks.css" />
  <link rel="alternate stylesheet" type="text/css" title="OracleEM" href="http://www.oracle-base.com/css/OracleEM.css" />
  <link rel="alternate stylesheet" type="text/css" title="Olive" href="http://www.oracle-base.com/css/Olive.css" />
  <link rel="alternate stylesheet" type="text/css" title="HighContrast" href="http://www.oracle-base.com/css/HighContrast.css" />
  <link rel="alternate stylesheet" type="text/css" title="Inverted" href="http://www.oracle-base.com/css/Inverted.css" />
  <script type="text/javascript" src="http://www.oracle-base.com/includes/common.js"></script>
  <script type="text/javascript" src="http://www.oracle-base.com/includes/switcher.js"></script>
</head>
<body>

  <table style="width:100%; text-align:center; border-spacing:0px">
    <tr>
      <td style="text-align:left; vertical-align:bottom">
        <a href="http://www.oracle-base.com/index.php"><img src="http://www.oracle-base.com/images/Title.gif" style="height:43px; width:243px" alt="" /></a>
      </td>
      <td style="width:735px; text-align:right; vertical-align:middle">
        <script type="text/javascript"><!--
        google_ad_client = "pub-9901106718381505";
        google_ad_width = 728;
        google_ad_height = 90;
        google_ad_format = "728x90_as";
        google_color_border = "C0C0C1";
        google_color_bg = "FFFFFF";
        google_color_link = "666699";
        google_color_url = "666699";
        google_color_text = "404040";
        //--></script>
        <script type="text/javascript"
          src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
        </script>
      </td>
    </tr>
  </table>

  <table style="text-align:center; width:100%; padding:1px; border-spacing:1px">
    <tr>
      <td class="menu_box">
        <!-- Toolbar *************************************************************************************  -->
        <table class="menu">
          <tr><td class="menutitle">This Site</td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/index.php">Home</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/dba/DBACategories.php">DBA Scripts</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/articles/8i/Articles8i.php">Oracle 8i Articles</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/articles/9i/Articles9i.php">Oracle 9i Articles</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/articles/10g/Articles10g.php">Oracle 10g Articles</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/articles/misc/ArticlesMisc.php">Miscellaneous Articles</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/articles/linux/ArticlesLinux.php">Linux Articles</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/misc/OCPCertification.php">Oracle Certification</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/forums/">Forums</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/blog/">ORACLE-BASE Blog</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/aggregator/index.php">Blog Aggregator</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/misc/IndustryNews.php">Industry News</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/books/Books.php">Book Store</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/misc/TSHSQL.php">TSHSQL Download</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/misc/Firefox.php">Firefox Search Plugins</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/misc/SiteInfo.php">Site Info</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle-base.com/links/Links.php">Links</a></td></tr>
          
          <tr><td class="menutitle" style="text-align:center; width:100%" align="center">Oracle Sites</td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/">Oracle Corporation</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/technology">Technology Network</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://metalink.oracle.com/">Oracle Metalink</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/education/certification/">Oracle Certification</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/oramag/">Oracle Magazine</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://asktom.oracle.com">Ask Tom</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/pls/tahiti/homepage?remark=tahiti">Oracle 8i R3 Docs</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/pls/db901/homepage?remark=tahiti">Oracle 9i R1 Docs</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/pls/db92/homepage?remark=tahiti">Oracle 9i R2 Docs</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/pls/db10g/homepage?remark=tahiti">Oracle 10g R1 Docs</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/pls/db102/homepage?remark=tahiti">Oracle 10g R2 Docs</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/technology/documentation/ias.html">Oracle 9iAS Docs</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/pls/ias904/homepage?remark=tahiti">Oracle AS10g R1 Docs</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/pls/as1012/homepage?remark=tahiti">Oracle AS10g R2 Docs</a></td></tr>
          <tr><td class="menu">&nbsp;<a class="menu" href="http://www.oracle.com/pls/as1013/homepage?remark=tahiti">Oracle AS10g R3 Docs</a></td></tr>

          <tr>
            <td class="menu">
              <br />

              <!-- Error Messages -->
              <script type="text/javascript">
                <!--
                function fnErrorMessageGo(form) {
                  var error_url;
                  for (var i=0; i < form.error_url.length; i++) {
                    if (form.error_url[i].checked)
                      error_url = form.error_url[i].value + form.search.value;
                  }
                  window.location = error_url;
                }
                -->
              </script>
              <form method="post" action="">
              <table style="text-align:center; width:100%">
                <tr>
                  <td style="text-align:center; width:100%; padding:1px; border-spacing:1px; border: 1px #616161 solid">
                    <table style="width:100%; padding:0px; border-spacing:0px">
                      <tr>
                        <td class="small">
                          Error Messages
                        </td>
                      </tr>
                      <tr>
                        <td class="small">
                          <input class="small" type="text" name="search" size="10" maxlength="255" value="ORA-" />
                          <input class="smallbtn" type="button" value="Go" onclick="javascript:fnErrorMessageGo(this.form)" /><br />
                          <table style="padding:0px; border-spacing:0px">
                            <tr>
                              <td class="small" colspan="2"><input type="radio" name="error_url" value="http://tahiti.oracle.com/pls/tahiti/tahiti.error_search?search=" />8i R3</td>
                            </tr>
                            <tr>
                              <td class="small"><input type="radio" name="error_url" value="http://tahiti.oracle.com/pls/db901/db901.error_search?search=" />9i R1</td>
                              <td class="small"><input type="radio" name="error_url" value="http://tahiti.oracle.com/pls/db92/db92.error_search?search=" />9i R2</td>
                            </tr>
                            <tr>
                              <td class="small"><input type="radio" name="error_url" value="http://tahiti.oracle.com/pls/db10g/db10g.error_search?search=" />10g R1</td>
                              <td class="small"><input type="radio" name="error_url" value="http://tahiti.oracle.com/pls/db102/db102.error_search?search=" checked="checked" />10g R2</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              </form>
              <!-- Error Messages -->
            </td>
          </tr>

          <tr>
            <td class="menu">
              <!-- Search Documentation -->
              <script type="text/javascript">
                <!--
                function fnDocSearchGo(form) {
                  var doc_url;
                  for (var i=0; i < form.doc_url.length; i++) {
                    if (form.doc_url[i].checked)
                      doc_url = form.doc_url[i].value + form.word.value;
                  }
                  window.location = doc_url;
                }
                -->
              </script>
              <form method="post" action="">
              <table style="text-align:center; width:100%">
                <tr>
                  <td style="text-align:center; width:100%; padding:1px; border-spacing:1px; border: 1px #616161 solid">
                    <table style="width:100%; padding:0px; border-spacing:0px">
                      <tr>
                        <td class="small">
                          Search Oracle Docs
                        </td>
                      </tr>
                      <tr>
                        <td class="small">
                          <input class="small" type="text" name="word" size="10" maxlength="255" value="" />
                          <input class="smallbtn" type="button" value="Go" onclick="javascript:fnDocSearchGo(this.form)" /><br />
                          <table cellpadding="0" cellspacing="0">
                            <tr>
                              <td class="small"><input type="radio" name="doc_url" value="http://metalink.oracle.com/metalink/plsql/ml2_gui.handleSearchRequest?p_text=" />Metalink</td>
                              <td class="small"><input type="radio" name="doc_url" value="http://tahiti.oracle.com/pls/tahiti/tahiti.drilldown?remark=quick_search&amp;word=" />8i R3</td>
                            </tr>
                            <tr>
                              <td class="small"><input type="radio" name="doc_url" value="http://tahiti.oracle.com/pls/db901/db901.drilldown?remark=quick_search&amp;word=" />9i R1</td>
                              <td class="small"><input type="radio" name="doc_url" value="http://tahiti.oracle.com/pls/db92/db92.drilldown?remark=quick_search&amp;word=" />9i R2</td>
                            </tr>
                            <tr>
                              <td class="small"><input type="radio" name="doc_url" value="http://tahiti.oracle.com/pls/db10g/db10g.drilldown?remark=quick_search&amp;word=" />10g R1</td>
                              <td class="small"><input type="radio" name="doc_url" value="http://tahiti.oracle.com/pls/db102/drilldown?remark=quick_search&amp;word=" checked="checked" />10g R2</td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              </form>
              <!-- Search Documentation -->
            </td>
          </tr>

          <tr>
            <td class="menu">
              <!-- Search Google -->
              <form method="get" action="http://www.oracle-base.com/misc/SearchResults.php">
              <table style="text-align:center; width:100%">
                <tr>
                  <td style="text-align:center; width:100%; padding:1px; border-spacing:1px; border: 1px #616161 solid">
                    <table style="width:100%; padding:0px; border-spacing:0px">
                      <tr>
                        <td class="small">
                          <a href="http://www.google.com/custom"><img src="http://www.oracle-base.com/images/GoogleSmall.gif" alt="Google" /></a>
                        </td>
                      </tr>
                      <tr>
                        <td class="small">
                          <input class="small" type="text" name="q" size="10" maxlength="255" value="" />
                          <input class="smallbtn" type="submit" name="sa" value="Go" />
                          <input type="hidden" name="domains" value="oracle-base.com" /><br />
                          <input type="radio" name="sitesearch" value="oracle-base.com" checked="checked" />Site
                          <input type="radio" name="sitesearch" value="" />Web

                          <input type="hidden" name="client" value="pub-9901106718381505" />
                          <input type="hidden" name="forid" value="1" />
                          <input type="hidden" name="ie" value="ISO-8859-1" />
                          <input type="hidden" name="oe" value="ISO-8859-1" />
                          <input type="hidden" name="cof" value="GALT:#666699;GL:1;DIV:#C0C0C1;VLC:666699;AH:center;BGC:FFFFFF;LBGC:FFFFFF;ALC:666699;LC:666699;T:404040;GFNT:C0C0C1;GIMP:C0C0C1;FORID:11" />
                          <input type="hidden" name="hl" value="en" />
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              </form>
              <!-- Search Google -->
            </td>
          </tr>

          <tr><td class="menu" style="text-align:center"><a href="http://www.rampant-books.com/menu_oracle.htm"><img src="http://www.fast-track.cc/images/adrampant.gif" alt="" style="height:90px; width:120px" /></a></td></tr>        </table>
        <br />

      </td>
      <td class="main_box">

<!-- End of PageHeader.php -->

<!-- Start of Content -->

  <h1>DBA Scripts</h1>

  <table>
    <tr>
      <td>
        Here are some of the scripts I use regularly. Some of them are not necessary when using Oracle Enterprise Manager (OEM), but if like men        you hate waiting around for OEM to start up you'll often get the job done more quickly with these. Cheers Tim...
  <br />
  <br />
  These scripts can be used by <a href="http://www.wangz.net/easyscript.php">easyscript for oracle</a> and are available in the file <a href="../downloads/oraclebase.esp">oraclebase.esp</a> produced by James Wang of Gudu Software.
  Alternatively, download all the scripts in a single zip file (<a href="dba.zip">dba.zip</a>).
      </td>
    </tr>
  </table>
  <br />

  <br />
  <table style="width:95%; border-spacing:0px">
    <tr>
      <td class="border_top"><img src="../images/Transparent.gif" alt="" style="width:100%; height:1px" /></td>
    </tr>
    <tr>
      <td style="width:100%; height:1px; text-align:left"><b>10g...</b></td>
    </tr>
  </table>
  <table style="width:90%">
    <tr>
      <td style="width:30%"><a href="10g/active_session_waits.sql">active_session_waits.sql</a></td>
      <td style="width:30%"><a href="10g/db_usage_hwm.sql">db_usage_hwm.sql</a></td>
      <td style="width:30%"><a href="10g/dynamic_memory.sql">dynamic_memory.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="10g/feature_usage.sql">feature_usage.sql</a></td>
      <td style="width:30%"><a href="10g/job_classes.sql">job_classes.sql</a></td>
      <td style="width:30%"><a href="10g/job_programs.sql">job_programs.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="10g/job_schedules.sql">job_schedules.sql</a></td>
      <td style="width:30%"><a href="10g/jobs.sql">jobs.sql</a></td>
      <td style="width:30%"><a href="10g/jobs_running.sql">jobs_running.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="10g/lock_tree.sql">lock_tree.sql</a></td>
      <td style="width:30%"><a href="10g/segment_advisor.sql">segment_advisor.sql</a></td>
      <td style="width:30%"><a href="10g/services.sql">services.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="10g/session_waits.sql">session_waits.sql</a></td>
      <td style="width:30%"><a href="10g/window_groups.sql">window_groups.sql</a></td>
      <td style="width:30%"><a href="10g/windows.sql">windows.sql</a></td>
    </tr>
  </table>

  <br />
  <table style="width:95%; border-spacing:0px">
    <tr>
      <td class="border_top"><img src="../images/Transparent.gif" alt="" style="width:100%; height:1px" /></td>
    </tr>
    <tr>
      <td style="width:100%; height:1px; text-align:left"><b>constraints...</b></td>
    </tr>
  </table>
  <table style="width:90%">
    <tr>
      <td style="width:30%"><a href="constraints/disable_chk.sql">disable_chk.sql</a></td>
      <td style="width:30%"><a href="constraints/disable_fk.sql">disable_fk.sql</a></td>
      <td style="width:30%"><a href="constraints/disable_pk.sql">disable_pk.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="constraints/disable_ref_fk.sql">disable_ref_fk.sql</a></td>
      <td style="width:30%"><a href="constraints/enable_chk.sql">enable_chk.sql</a></td>
      <td style="width:30%"><a href="constraints/enable_fk.sql">enable_fk.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="constraints/enable_pk.sql">enable_pk.sql</a></td>
      <td style="width:30%"><a href="constraints/enable_ref_fk.sql">enable_ref_fk.sql</a></td>
    </tr>
  </table>

  <br />
  <table style="width:95%; border-spacing:0px">
    <tr>
      <td class="border_top"><img src="../images/Transparent.gif" alt="" style="width:100%; height:1px" /></td>
    </tr>
    <tr>
      <td style="width:100%; height:1px; text-align:left"><b>miscellaneous...</b></td>
    </tr>
  </table>
  <table style="width:90%">
    <tr>
      <td style="width:30%"><a href="miscellaneous/analyze_all.sql">analyze_all.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/column_comments.sql">column_comments.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/comments.sql">comments.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/compare_schemas.sql">compare_schemas.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/compile_all.sql">compile_all.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/compile_all_bodies.sql">compile_all_bodies.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/compile_all_funcs.sql">compile_all_funcs.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/compile_all_procs.sql">compile_all_procs.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/compile_all_specs.sql">compile_all_specs.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/compile_all_trigs.sql">compile_all_trigs.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/compile_all_views.sql">compile_all_views.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/conversion_api.sql">conversion_api.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/dict_comments.sql">dict_comments.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/drop_all.sql">drop_all.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/dsp.pkb">dsp.pkb</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/dsp.pks">dsp.pks</a></td>
      <td style="width:30%"><a href="miscellaneous/err.pkb">err.pkb</a></td>
      <td style="width:30%"><a href="miscellaneous/err.pks">err.pks</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/ftp.pkb">ftp.pkb</a></td>
      <td style="width:30%"><a href="miscellaneous/ftp.pks">ftp.pks</a></td>
      <td style="width:30%"><a href="miscellaneous/gen_health.sql">gen_health.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/get_pivot.sql">get_pivot.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/login.sql">login.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/proc_defs.sql">proc_defs.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/rebuild_index.sql">rebuild_index.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/soap_api.sql">soap_api.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/string_agg.sql">string_agg.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/string_api.sql">string_api.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/switch_schema.sql">switch_schema.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/table_comments.sql">table_comments.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/table_defs.sql">table_defs.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/table_differences.sql">table_differences.sql</a></td>
      <td style="width:30%"><a href="miscellaneous/trc.pkb">trc.pkb</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="miscellaneous/trc.pks">trc.pks</a></td>
    </tr>
  </table>

  <br />
  <table style="width:95%; border-spacing:0px">
    <tr>
      <td class="border_top"><img src="../images/Transparent.gif" alt="" style="width:100%; height:1px" /></td>
    </tr>
    <tr>
      <td style="width:100%; height:1px; text-align:left"><b>monitoring...</b></td>
    </tr>
  </table>
  <table style="width:90%">
    <tr>
      <td style="width:30%"><a href="monitoring/access.sql">access.sql</a></td>
      <td style="width:30%"><a href="monitoring/active_sessions.sql">active_sessions.sql</a></td>
      <td style="width:30%"><a href="monitoring/cache_hit_ratio.sql">cache_hit_ratio.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/call_stack.sql">call_stack.sql</a></td>
      <td style="width:30%"><a href="monitoring/code_dep.sql">code_dep.sql</a></td>
      <td style="width:30%"><a href="monitoring/code_dep_on.sql">code_dep_on.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/column_defaults.sql">column_defaults.sql</a></td>
      <td style="width:30%"><a href="monitoring/db_cache_advice.sql">db_cache_advice.sql</a></td>
      <td style="width:30%"><a href="monitoring/db_info.sql">db_info.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/db_properties.sql">db_properties.sql</a></td>
      <td style="width:30%"><a href="monitoring/dispatchers.sql">dispatchers.sql</a></td>
      <td style="width:30%"><a href="monitoring/error_stack.sql">error_stack.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/errors.sql">errors.sql</a></td>
      <td style="width:30%"><a href="monitoring/explain.sql">explain.sql</a></td>
      <td style="width:30%"><a href="monitoring/file_io.sql">file_io.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/fk_columns.sql">fk_columns.sql</a></td>
      <td style="width:30%"><a href="monitoring/fks.sql">fks.sql</a></td>
      <td style="width:30%"><a href="monitoring/free_space.sql">free_space.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/health.sql">health.sql</a></td>
      <td style="width:30%"><a href="monitoring/hidden_parameters.sql">hidden_parameters.sql</a></td>
      <td style="width:30%"><a href="monitoring/high_water_mark.sql">high_water_mark.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/hot_blocks.sql">hot_blocks.sql</a></td>
      <td style="width:30%"><a href="monitoring/identify_trace_file.sql">identify_trace_file.sql</a></td>
      <td style="width:30%"><a href="monitoring/index_extents.sql">index_extents.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/index_monitoring_status.sql">index_monitoring_status.sql</a></td>
      <td style="width:30%"><a href="monitoring/index_partitions.sql">index_partitions.sql</a></td>
      <td style="width:30%"><a href="monitoring/index_usage.sql">index_usage.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/invalid_objects.sql">invalid_objects.sql</a></td>
      <td style="width:30%"><a href="monitoring/jobs.sql">jobs.sql</a></td>
      <td style="width:30%"><a href="monitoring/jobs_running.sql">jobs_running.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/latch_hit_ratios.sql">latch_hit_ratios.sql</a></td>
      <td style="width:30%"><a href="monitoring/latch_holders.sql">latch_holders.sql</a></td>
      <td style="width:30%"><a href="monitoring/latches.sql">latches.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/library_cache.sql">library_cache.sql</a></td>
      <td style="width:30%"><a href="monitoring/license.sql">license.sql</a></td>
      <td style="width:30%"><a href="monitoring/locked_objects.sql">locked_objects.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/longops.sql">longops.sql</a></td>
      <td style="width:30%"><a href="monitoring/lru_latch_ratio.sql">lru_latch_ratio.sql</a></td>
      <td style="width:30%"><a href="monitoring/max_extents.sql">max_extents.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/monitor.sql">monitor.sql</a></td>
      <td style="width:30%"><a href="monitoring/monitor_memory.sql">monitor_memory.sql</a></td>
      <td style="width:30%"><a href="monitoring/monitoring_status.sql">monitoring_status.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/non_indexed_fks.sql">non_indexed_fks.sql</a></td>
      <td style="width:30%"><a href="monitoring/obj_lock.sql">obj_lock.sql</a></td>
      <td style="width:30%"><a href="monitoring/object_status.sql">object_status.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/open_cursors.sql">open_cursors.sql</a></td>
      <td style="width:30%"><a href="monitoring/open_cursors_by_sid.sql">open_cursors_by_sid.sql</a></td>
      <td style="width:30%"><a href="monitoring/open_cursors_full_by_sid.sql">open_cursors_full_by_sid.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/parameter_diffs.sql">parameter_diffs.sql</a></td>
      <td style="width:30%"><a href="monitoring/parameters.sql">parameters.sql</a></td>
      <td style="width:30%"><a href="monitoring/pga_target_advice.sql">pga_target_advice.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/pipes.sql">pipes.sql</a></td>
      <td style="width:30%"><a href="monitoring/profiler_run_details.sql">profiler_run_details.sql</a></td>
      <td style="width:30%"><a href="monitoring/profiler_runs.sql">profiler_runs.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/rbs_extents.sql">rbs_extents.sql</a></td>
      <td style="width:30%"><a href="monitoring/rbs_stats.sql">rbs_stats.sql</a></td>
      <td style="width:30%"><a href="monitoring/recovery_status.sql">recovery_status.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/roles.sql">roles.sql</a></td>
      <td style="width:30%"><a href="monitoring/search_source.sql">search_source.sql</a></td>
      <td style="width:30%"><a href="monitoring/segment_stats.sql">segment_stats.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/session_events.sql">session_events.sql</a></td>
      <td style="width:30%"><a href="monitoring/session_events_by_sid.sql">session_events_by_sid.sql</a></td>
      <td style="width:30%"><a href="monitoring/session_events_by_spid.sql">session_events_by_spid.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/session_io.sql">session_io.sql</a></td>
      <td style="width:30%"><a href="monitoring/session_rollback.sql">session_rollback.sql</a></td>
      <td style="width:30%"><a href="monitoring/session_stats.sql">session_stats.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/session_stats_by_sid.sql">session_stats_by_sid.sql</a></td>
      <td style="width:30%"><a href="monitoring/session_undo.sql">session_undo.sql</a></td>
      <td style="width:30%"><a href="monitoring/session_waits.sql">session_waits.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/sessions.sql">sessions.sql</a></td>
      <td style="width:30%"><a href="monitoring/show_indexes.sql">show_indexes.sql</a></td>
      <td style="width:30%"><a href="monitoring/show_space.sql">show_space.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/show_tables.sql">show_tables.sql</a></td>
      <td style="width:30%"><a href="monitoring/source.sql">source.sql</a></td>
      <td style="width:30%"><a href="monitoring/spfile_parameters.sql">spfile_parameters.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/sql_area.sql">sql_area.sql</a></td>
      <td style="width:30%"><a href="monitoring/sql_text.sql">sql_text.sql</a></td>
      <td style="width:30%"><a href="monitoring/sql_text_by_sid.sql">sql_text_by_sid.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/system_events.sql">system_events.sql</a></td>
      <td style="width:30%"><a href="monitoring/system_parameters.sql">system_parameters.sql</a></td>
      <td style="width:30%"><a href="monitoring/system_stats.sql">system_stats.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/table_dep.sql">table_dep.sql</a></td>
      <td style="width:30%"><a href="monitoring/table_extents.sql">table_extents.sql</a></td>
      <td style="width:30%"><a href="monitoring/table_indexes.sql">table_indexes.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/table_partitions.sql">table_partitions.sql</a></td>
      <td style="width:30%"><a href="monitoring/table_stats.sql">table_stats.sql</a></td>
      <td style="width:30%"><a href="monitoring/temp_io.sql">temp_io.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/temp_segments.sql">temp_segments.sql</a></td>
      <td style="width:30%"><a href="monitoring/top_latches.sql">top_latches.sql</a></td>
      <td style="width:30%"><a href="monitoring/top_sessions.sql">top_sessions.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/top_sql.sql">top_sql.sql</a></td>
      <td style="width:30%"><a href="monitoring/trace_run_details.sql">trace_run_details.sql</a></td>
      <td style="width:30%"><a href="monitoring/trace_runs.sql">trace_runs.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/ts_extent_map.sql">ts_extent_map.sql</a></td>
      <td style="width:30%"><a href="monitoring/ts_full.sql">ts_full.sql</a></td>
      <td style="width:30%"><a href="monitoring/tuning.sql">tuning.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="monitoring/unusable_indexes.sql">unusable_indexes.sql</a></td>
      <td style="width:30%"><a href="monitoring/unused_space.sql">unused_space.sql</a></td>
      <td style="width:30%"><a href="monitoring/user_hit_ratio.sql">user_hit_ratio.sql</a></td>
    </tr>
  </table>

  <br />
  <table style="width:95%; border-spacing:0px">
    <tr>
      <td class="border_top"><img src="../images/Transparent.gif" alt="" style="width:100%; height:1px" /></td>
    </tr>
    <tr>
      <td style="width:100%; height:1px; text-align:left"><b>rac...</b></td>
    </tr>
  </table>
  <table style="width:90%">
    <tr>
      <td style="width:30%"><a href="rac/locked_objects_rac.sql">locked_objects_rac.sql</a></td>
      <td style="width:30%"><a href="rac/longops_rac.sql">longops_rac.sql</a></td>
      <td style="width:30%"><a href="rac/monitor_memory_rac.sql">monitor_memory_rac.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="rac/session_undo_rac.sql">session_undo_rac.sql</a></td>
      <td style="width:30%"><a href="rac/session_waits_rac.sql">session_waits_rac.sql</a></td>
      <td style="width:30%"><a href="rac/sessions_rac.sql">sessions_rac.sql</a></td>
    </tr>
  </table>

  <br />
  <table style="width:95%; border-spacing:0px">
    <tr>
      <td class="border_top"><img src="../images/Transparent.gif" alt="" style="width:100%; height:1px" /></td>
    </tr>
    <tr>
      <td style="width:100%; height:1px; text-align:left"><b>resource manager...</b></td>
    </tr>
  </table>
  <table style="width:90%">
    <tr>
      <td style="width:30%"><a href="resource_manager/active_plan.sql">active_plan.sql</a></td>
      <td style="width:30%"><a href="resource_manager/consumer_group_usage.sql">consumer_group_usage.sql</a></td>
      <td style="width:30%"><a href="resource_manager/consumer_groups.sql">consumer_groups.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="resource_manager/plan_directives.sql">plan_directives.sql</a></td>
      <td style="width:30%"><a href="resource_manager/resource_plans.sql">resource_plans.sql</a></td>
    </tr>
  </table>

  <br />
  <table style="width:95%; border-spacing:0px">
    <tr>
      <td class="border_top"><img src="../images/Transparent.gif" alt="" style="width:100%; height:1px" /></td>
    </tr>
    <tr>
      <td style="width:100%; height:1px; text-align:left"><b>script creation...</b></td>
    </tr>
  </table>
  <table style="width:90%">
    <tr>
      <td style="width:30%"><a href="script_creation/backup.sql">backup.sql</a></td>
      <td style="width:30%"><a href="script_creation/build_api.sql">build_api.sql</a></td>
      <td style="width:30%"><a href="script_creation/build_api2.sql">build_api2.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="script_creation/create_data.sql">create_data.sql</a></td>
      <td style="width:30%"><a href="script_creation/drop_cons_on_table.sql">drop_cons_on_table.sql</a></td>
      <td style="width:30%"><a href="script_creation/drop_fks_on_table.sql">drop_fks_on_table.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="script_creation/drop_fks_ref_table.sql">drop_fks_ref_table.sql</a></td>
      <td style="width:30%"><a href="script_creation/drop_indexes.sql">drop_indexes.sql</a></td>
      <td style="width:30%"><a href="script_creation/fks_on_table.sql">fks_on_table.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="script_creation/fks_ref_table.sql">fks_ref_table.sql</a></td>
      <td style="width:30%"><a href="script_creation/index_monitoring_off.sql">index_monitoring_off.sql</a></td>
      <td style="width:30%"><a href="script_creation/index_monitoring_on.sql">index_monitoring_on.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="script_creation/monitoring_off.sql">monitoring_off.sql</a></td>
      <td style="width:30%"><a href="script_creation/monitoring_on.sql">monitoring_on.sql</a></td>
      <td style="width:30%"><a href="script_creation/rbs_structure.sql">rbs_structure.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="script_creation/recreate_table.sql">recreate_table.sql</a></td>
      <td style="width:30%"><a href="script_creation/seq_structure.sql">seq_structure.sql</a></td>
      <td style="width:30%"><a href="script_creation/table_constraints.sql">table_constraints.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="script_creation/table_indexes.sql">table_indexes.sql</a></td>
      <td style="width:30%"><a href="script_creation/table_structure.sql">table_structure.sql</a></td>
      <td style="width:30%"><a href="script_creation/tablespace_structure.sql">tablespace_structure.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="script_creation/view_structure.sql">view_structure.sql</a></td>
    </tr>
  </table>

  <br />
  <table style="width:95%; border-spacing:0px">
    <tr>
      <td class="border_top"><img src="../images/Transparent.gif" alt="" style="width:100%; height:1px" /></td>
    </tr>
    <tr>
      <td style="width:100%; height:1px; text-align:left"><b>security...</b></td>
    </tr>
  </table>
  <table style="width:90%">
    <tr>
      <td style="width:30%"><a href="security/grant_delete.sql">grant_delete.sql</a></td>
      <td style="width:30%"><a href="security/grant_execute.sql">grant_execute.sql</a></td>
      <td style="width:30%"><a href="security/grant_insert.sql">grant_insert.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="security/grant_select.sql">grant_select.sql</a></td>
      <td style="width:30%"><a href="security/grant_update.sql">grant_update.sql</a></td>
      <td style="width:30%"><a href="security/package_synonyms.sql">package_synonyms.sql</a></td>
    </tr>
    <tr>
      <td style="width:30%"><a href="security/sequence_synonyms.sql">sequence_synonyms.sql</a></td>
      <td style="width:30%"><a href="security/table_synonyms.sql">table_synonyms.sql</a></td>
      <td style="width:30%"><a href="security/view_synonyms.sql">view_synonyms.sql</a></td>
    </tr>
  </table>
  <br />

<!-- End of Content -->

<!-- Start of PageFooter.php -->
      </td>
    </tr>
  </table>

  <div class="center">

  
    <br />

    <script type="text/javascript"><!--
    google_ad_client = "pub-9901106718381505";
    google_ad_width = 728;
    google_ad_height = 90;
    google_ad_format = "728x90_as";
    google_color_border = "C0C0C1";
    google_color_bg = "FFFFFF";
    google_color_link = "666699";
    google_color_url = "666699";
    google_color_text = "404040";
    //--></script>
    <script type="text/javascript"
      src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
    </script>

    <br />

    <table style="width:100%">
      <tr>
        <td style="width:33%; text-align:left">
          <a href="http://validator.w3.org/check?uri=referer"><img src="http://www.w3.org/Icons/valid-xhtml11" alt="Valid XHTML 1.1" height="31" width="88" /></a>
        </td>
        <td style="width:34%; text-align:center">
          <a class="footer" href="http://www.oracle-base.com/misc/SiteInfo.php#copyright">Copyright &amp; Disclaimer</a>
        </td>
        <td style="width:33%; text-align:right">
          <a href="http://jigsaw.w3.org/css-validator/check/referer"><img style="border:0;width:88px;height:31px" src="http://jigsaw.w3.org/css-validator/images/vcss" alt="Valid CSS!" /></a>
        </td>
      </tr>
    </table>
    
  </div>

<!-- End of PageFooter.php -->

<!-- Start of HtmlFooter.php -->
</body>
</html>


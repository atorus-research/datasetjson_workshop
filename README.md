
# datasetjson - Read and write CDISC Dataset JSON formatted datasets in R and Python

### R/Pharma 2025 Workshop

by Mike Stackhouse, Sam Hume, Nick Masel and Eli Miller

------------------------------------------------------------------------

:spiral_calendar: November 7, 2025  
:alarm_clock: 08:00 - 11:00 Eastern  
:computer: Virtual  
:writing_hand: [R/Pharma 2025
Workshop](https://rinpharma.com/docs/RPH2025/)

------------------------------------------------------------------------

## Description

Join us for an engaging workshop designed to introduce Dataset-JSON, a
powerful format for sharing datasets. We’ll start with an environment
setup and explore the motivation behind choosing Dataset-JSON over other
formats like Parquet. The session will include a detailed walkthrough of
the Dataset-JSON specification, followed by hands-on demonstrations and
exercises in both R and Python.

Discover how to implement Dataset-JSON in your workflows, learn about
upcoming adoption plans, and explore future roadmap and API
integrations. This workshop is perfect for data professionals interested
in improving dataset interoperability and sharing standards.

## Setup

1.  Sign-in to Posit.Cloud [here](https://login.posit.cloud/). If you do
    not have an account, create a free one
    [here](https://login.posit.cloud/register?redirect=%2F).

2.  Access our Posit.Cloud workshop
    [here](https://posit.cloud/spaces/717326/join?access_code=PJ9jXpW21PMqrENRNTQ3r-g0kJ_PUMqM_pWTa6CS)

3.  Copy the workshop and open.

## Schedule

<div id="okeieofydt" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#okeieofydt table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#okeieofydt thead, #okeieofydt tbody, #okeieofydt tfoot, #okeieofydt tr, #okeieofydt td, #okeieofydt th {
  border-style: none;
}
&#10;#okeieofydt p {
  margin: 0;
  padding: 0;
}
&#10;#okeieofydt .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#okeieofydt .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#okeieofydt .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#okeieofydt .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#okeieofydt .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#okeieofydt .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#okeieofydt .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#okeieofydt .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#okeieofydt .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#okeieofydt .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#okeieofydt .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#okeieofydt .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#okeieofydt .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#okeieofydt .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#okeieofydt .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#okeieofydt .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#okeieofydt .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#okeieofydt .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#okeieofydt .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#okeieofydt .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#okeieofydt .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#okeieofydt .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#okeieofydt .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#okeieofydt .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#okeieofydt .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#okeieofydt .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#okeieofydt .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#okeieofydt .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#okeieofydt .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#okeieofydt .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#okeieofydt .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#okeieofydt .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#okeieofydt .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#okeieofydt .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#okeieofydt .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#okeieofydt .gt_left {
  text-align: left;
}
&#10;#okeieofydt .gt_center {
  text-align: center;
}
&#10;#okeieofydt .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#okeieofydt .gt_font_normal {
  font-weight: normal;
}
&#10;#okeieofydt .gt_font_bold {
  font-weight: bold;
}
&#10;#okeieofydt .gt_font_italic {
  font-style: italic;
}
&#10;#okeieofydt .gt_super {
  font-size: 65%;
}
&#10;#okeieofydt .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#okeieofydt .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#okeieofydt .gt_indent_1 {
  text-indent: 5px;
}
&#10;#okeieofydt .gt_indent_2 {
  text-indent: 10px;
}
&#10;#okeieofydt .gt_indent_3 {
  text-indent: 15px;
}
&#10;#okeieofydt .gt_indent_4 {
  text-indent: 20px;
}
&#10;#okeieofydt .gt_indent_5 {
  text-indent: 25px;
}
&#10;#okeieofydt .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#okeieofydt div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="time"><span class='gt_from_md'><strong>Time</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="desc"><span class='gt_from_md'><strong>Activity</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="time" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'>08:00 - 08:15</span></td>
<td headers="desc" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'><a href="https://atorus-research.github.io/datasetjson_workshop/slides/01-intro/#/title-slide">Introduction + Overview</a></span></td></tr>
    <tr><td headers="time" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'>08:15 - 08:45</span></td>
<td headers="desc" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'><a href="https://atorus-research.github.io/datasetjson_workshop/slides/02-why/#/title-slide">Why Change / Why Dataset-JSON / Why not Parquet?</a></span></td></tr>
    <tr><td headers="time" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'>08:45 - 09:15</span></td>
<td headers="desc" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'><a href="https://atorus-research.github.io/datasetjson_workshop/slides/03-what/#/title-slide">What is Dataset-JSON</a></span></td></tr>
    <tr><td headers="time" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'>09:15 - 09:30</span></td>
<td headers="desc" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'><em>Coffee Break</em></span></td></tr>
    <tr><td headers="time" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'>09:30 - 10:00</span></td>
<td headers="desc" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'><a href="https://atorus-research.github.io/datasetjson_workshop/slides/04-how-r/#/title-slide">How to in R</a></span></td></tr>
    <tr><td headers="time" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'>10:00 - 10:30</span></td>
<td headers="desc" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'><a href="https://atorus-research.github.io/datasetjson_workshop/slides/05-how-pyr/#/title-slide">How to in python</a></span></td></tr>
    <tr><td headers="time" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'>10:30 - 10:55</span></td>
<td headers="desc" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'><a href="https://atorus-research.github.io/datasetjson_workshop/slides/06-future/#/title-slide">Adoption and Future</a></span></td></tr>
    <tr><td headers="time" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'>10:55 - 11:00</span></td>
<td headers="desc" class="gt_row gt_left" style="vertical-align:top"><span class='gt_from_md'><a href="https://atorus-research.github.io/datasetjson_workshop/slides/07-wrapup/#/title-slide">Wrap-up</a></span></td></tr>
  </tbody>
  &#10;  
</table>
</div>

------------------------------------------------------------------------

![](https://i.creativecommons.org/l/by/4.0/88x31.png) This work is
licensed under a [Creative Commons Attribution 4.0 International
License](https://creativecommons.org/licenses/by/4.0/).

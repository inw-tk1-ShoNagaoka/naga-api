<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/calendar.css" >

<title>Calendar</title>
</head>
<body>
<form id="move" action="/naga-api/Calendar" method="post" >
  <input type="hidden" name="dspYY" value="<%= request.getAttribute( "reqYY" ) %>" />
  <input type="hidden" name="dspMM" value="<%= request.getAttribute( "reqMM" ) %>" />
  <input id="prev" type="submit" name="reqCode" value="prev" />
  <input id="next" type="submit" name="reqCode" value="next" />
</form>
<div id="calendar"></div>



<script type="text/javascript">
  const weeks = ['日', '月', '火', '水', '木', '金', '土'];
  const date = new Date();
  const year = <%= request.getAttribute( "reqYY" ) %>;
  const month = <%= request.getAttribute( "reqMM" ) %>;
  const config = {show: 1};

  console.log(date.getFullYear());
  console.log(date.getMonth());
  console.log(date.getMonth()+1);

  function showCalendar(year, month) {
    for ( i = 0; i < config.show; i++) {
      const calendarHtml = createCalendar(year, month);
      const sec = document.createElement('section');
      sec.innerHTML = calendarHtml
      document.querySelector('#calendar').appendChild(sec)

      month++
      if (month > 12) {
        year++
        month = 1
      }
    }
  }

  function createCalendar(year, month) {
    const startDate = new Date(year, month - 1, 1); // 月の最初の日を取得
    const endDate = new Date(year, month,  0); // 月の最後の日を取得
    const endDayCount = endDate.getDate(); // 月の末日
    const lastMonthEndDate = new Date(year, month - 1, 0); // 前月の最後の日の情報
    const lastMonthendDayCount = lastMonthEndDate.getDate(); // 前月の末日
    const startDay = startDate.getDay(); // 月の最初の日の曜日を取得
    // 0:日、1:月、2:火、3:水、4:木、5：金、6:土

    let dayCount = 1; // 日にちのカウント
    let calendarHtml = '' // HTMLを組み立てる変数

    calendarHtml += '<h1>' + year  + '/' + month + '</h1>'
    calendarHtml += '<table>';
    calendarHtml += '<tr>';

    // 曜日の行を作成
    let i;
    for (i = 0; i < weeks.length; i++) {
      calendarHtml += '<td>' + weeks[i] + '</td>';
    }
    calendarHtml += '</tr>';

    let w;
    let d;
    // 行数を6週間分。
    for (w = 0; w < 6; w++) {
      calendarHtml += '<tr>'

      for (d = 0; d < 7; d++) {
        if (w == 0 && d < startDay) {
          // 1行目で1日の曜日の前
          // calendarHtml += '<td></td>'
          let num = lastMonthendDayCount - startDay + d + 1
          calendarHtml += '<td class="is-disabled">' + num + '</td>'
        } else if (dayCount > endDayCount) {
          // 末尾の日数を超えた
          // calendarHtml += '<td></td>'
          let num = dayCount - endDayCount
          calendarHtml += '<td class="is-disabled">' + num + '</td>'
          dayCount++
        } else {
          calendarHtml += '<td>' + dayCount + '</td>'
          dayCount++
        }
      }
      calendarHtml += '</tr>'
    }
    calendarHtml += '</table>'

    //document.querySelector('#calendar').innerHTML = calendarHtml
    return calendarHtml
  }

  function clickMoveMonth(reqCode) {
	  location.href = "/naga-api/Calendar?dspYY="+ year + "&dspMM="+ month + "&reqCode=" + reqCode;
  }

  showCalendar(year, month)

</script>

</body>
</html>
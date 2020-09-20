package jp.co.naga.servlet;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

/**
 * Servlet implementation class CalendarServlet
 */
public class CalendarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CalendarServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());

		// リクエストパラメタ取得
		request.setCharacterEncoding("UTF-8");
		// 表示年
		String l_dspYY = request.getParameter("dspYY");
		// 表示月
		String l_dspMM = request.getParameter("dspMM");
		// 要求指示（next、prev、specified）
		String l_reqCode = request.getParameter("reqCode");


		String l_reqYY = null;
		String l_reqMM = null;

		if(StringUtils.isEmpty(l_reqCode)){
			// 要求指示なしのため、初期表示として今月を設定

			Date l_date = new Date();
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(l_date);

			l_reqYY = String.valueOf(calendar.get(Calendar.YEAR));
			l_reqMM = String.valueOf(calendar.get(Calendar.MONTH) + 1);

		} else if(l_reqCode.equals("next")){
			// 翌月を返す
			int l_yy = Integer.parseInt(l_dspYY);
			int l_mm = Integer.parseInt(l_dspMM);
			if (l_mm == 12) {
				l_yy++;
				l_mm = 1;
			} else {
				l_mm++;
			}

			l_reqYY = String.valueOf(l_yy);
			l_reqMM = String.valueOf(l_mm);

		} else if(l_reqCode.equals("prev")){
			// 前月を返す
			int l_yy = Integer.parseInt(l_dspYY);
			int l_mm = Integer.parseInt(l_dspMM);
			if (l_mm == 1) {
				l_yy--;
				l_mm = 12;
			} else {
				l_mm--;
			}

			l_reqYY = String.valueOf(l_yy);
			l_reqMM = String.valueOf(l_mm);

		} else if(l_reqCode.equals("specified")){
			// 指定日付の年月を返す。

		}

		//response.setContentType("text/html;charset=UTF-8");
		//request.setCharacterEncoding("UTF-8");


		request.setAttribute("reqYY", l_reqYY);
		request.setAttribute("reqMM", l_reqMM);

		String path = "/WEB-INF/jsp/calendar.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		dispatcher.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Auto-generated method stub
		doGet(request, response);
	}

}

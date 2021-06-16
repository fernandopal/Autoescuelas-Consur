package es.fernandopal.autoescuela.filter;

import es.fernandopal.autoescuela.util.Label;
import es.fernandopal.autoescuela.util.Util;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "TestsFilter", urlPatterns = {"/tests/*"}, dispatcherTypes = {DispatcherType.REQUEST})
public class TestsFilter implements Filter {
    private FilterConfig filterConfig = null;
    private final Label labels = new Label();

    public TestsFilter() { }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        final HttpServletRequest httpRequest = (HttpServletRequest) request;
        final HttpServletResponse httpResponse = (HttpServletResponse) response;
        final String uri = httpRequest.getRequestURI();
        final String resource = uri.substring(uri.lastIndexOf("/") + 1);
        final HttpSession session = httpRequest.getSession();
        final boolean loggedInUser = session.getAttribute("usuario") != null;

        if (!loggedInUser) {
            System.out.println("[403] [" + request.getRemoteAddr() + "] " + resource);
            Util.sendMessage("403", "/home", labels.get("NEED_TO_LOGIN", session), httpRequest, httpResponse);
            return;
        }

        try { chain.doFilter(request, response); } catch (Throwable t) { t.printStackTrace(); }
    }

    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    public void destroy() { }

    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

}
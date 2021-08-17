<%-- 
    Document   : template-produto
    Created on : 13/09/2019, 18:51:42
    Author     : Caio
--%>
<%@page import="java.util.List"%>
<%@page import="br.uff.loja.core.dtos.AvaliacaoProdutoListDTO"%>
<%@page import="br.uff.loja.core.dtos.ProdutoVitrineUsuarioDTO"%>
<%@page import="java.util.ArrayList"%>
<%
    // recupera produtoId
    String produtoId = "";
    if (session.getAttribute("produtoId") != null) {
        produtoId = session.getAttribute("produtoId").toString();
    } else {
        response.sendRedirect("produto");
    }

    ProdutoVitrineUsuarioDTO produto = new ProdutoVitrineUsuarioDTO();
    List<AvaliacaoProdutoListDTO> avaliacoes = new ArrayList<AvaliacaoProdutoListDTO>();
    if (request.getAttribute("produto") != null) {
        produto = (ProdutoVitrineUsuarioDTO) request.getAttribute("produto");
        avaliacoes = (List<AvaliacaoProdutoListDTO>) request.getAttribute("avaliacoes");
    } else {
        session.setAttribute("msg", "Por favor selecione um produto!");
        response.sendRedirect("produtos");
        return;
    }

    //calcula resumo das avaliacoes
    double resumoAvaliacoes = 0;
    if (produto.getAvaliacaoDadaPeloUsuario() > 0) {
        resumoAvaliacoes = (double)produto.getSomaAvaliacoes() / (double)produto.getAvaliacaoDadaPeloUsuario();
    }
%>
<!-- Header -->
<jsp:include page="header.jsp">
    <jsp:param name="title" value="<%= produto.getNome() %>"/>
</jsp:include>

<main class="container">

    <!-- Coluna da esquerda / Imagem do produto -->
    <div class="left-column">
        <img src="<%= produto.getImagem() %>">
    </div>

    <!-- Coluna da direita -->
    <div class="right-column">

        <!-- Descri��o do produto -->
        <div class="product-description">
            <span><%= produto.getCategoria() %></span>
            <h1><%= produto.getNome() %></h1>
            <p><%= produto.getDescricao() %></p>
        </div>

        <!-- Pre�o do produto -->
        <div class="product-price">
            <span>R$<%= produto.getPreco() %></span>
            <a href="carrinho?addProdutoId=<%= produto.getId() %>" class="cart-btn">+ Carrinho</a>
            <!-- Bot�o de favorito -->
            <input <%= (produto.getFavoritoDoUsuario() ? "checked" : "")%> onchange="window.location.href = 'produto?fav=<%= produto.getId() %>'" id="toggle-heart" type="checkbox" />
            <label for="toggle-heart">&#x2764;</label>
        </div>
        <!-- Avalia��o do produto (em estrelas) -->
        <div class="rate" <%= (!produto.getAvaliacaoDadaPeloUsuario().equals("") ? "style='pointer-events:none'" : "")%>>
            <input <%= (produto.getAvaliacaoDadaPeloUsuario().equals(5) ? "checked" : "")%> onClick="window.location.href = 'avaliacao?produtoId=<%= produto.getId() %>&rating=5'" type="radio" id="star5" name="rate" value="5" />
            <label for="star5" title="text"></label>
            <input <%= (produto.getAvaliacaoDadaPeloUsuario().equals(4) ? "checked" : "")%> onClick="window.location.href = 'avaliacao?produtoId=<%= produto.getId() %>&rating=4'" type="radio" id="star4" name="rate" value="4" />
            <label for="star4" title="text"></label>
            <input <%= (produto.getAvaliacaoDadaPeloUsuario().equals(3) ? "checked" : "")%> onClick="window.location.href = 'avaliacao?produtoId=<%= produto.getId() %>&rating=3'" type="radio" id="star3" name="rate" value="3" />
            <label for="star3" title="text"></label>
            <input <%= (produto.getAvaliacaoDadaPeloUsuario().equals(2) ? "checked" : "")%> onClick="window.location.href = 'avaliacao?produtoId=<%= produto.getId() %>&rating=2'" type="radio" id="star2" name="rate" value="2" />
            <label for="star2" title="text"></label>
            <input <%= (produto.getAvaliacaoDadaPeloUsuario().equals(1) ? "checked" : "")%> onClick="window.location.href = 'avaliacao?produtoId=<%= produto.getId() %>&rating=1'" type="radio" id="star1" name="rate" value="1" />
            <label for="star1" title="text"></label>
        </div>
    </div>

</main>

<div class="product-rating">

    <!-- Coluna da esquerda (resumo da avalia��o) -->
    <div class="left-rating">
        <div class="review-resume">Resumo das avalia��es</div>
        <div class="review-rate"><%= resumoAvaliacoes%> / 5</div>
        <div class="review-list">
            <ul>
                <li>
                    <div>5 ESTRELAS</div>
                    <div class="percentage">
                        <div class="percentage-full" style="width: <%= produto.getBarra5Estrelas() %>%;"></div>
                    </div>
                    <div class="count"><%= produto.getQuantidadeAvaliacoesNota5() %></div>
                </li>
                <li>
                    <div>4 ESTRELAS</div>
                    <div class="percentage">
                        <div class="percentage-full" style="width: <%= produto.getBarra4Estrelas() %>%;"></div>
                    </div>
                    <div class="count"><%= produto.getQuantidadeAvaliacoesNota4() %></div>
                </li>
                <li>
                    <div>3 ESTRELAS</div>
                    <div class="percentage">
                        <div class="percentage-full" style="width: <%= produto.getBarra3Estrelas() %>%;"></div>
                    </div>
                    <div class="count"><%= produto.getQuantidadeAvaliacoesNota3() %></div>
                </li>
                <li>
                    <div>2 ESTRELAS</div>
                    <div class="percentage">
                        <div class="percentage-full" style="width: <%= produto.getBarra2Estrelas() %>%;"></div>
                    </div>
                    <div class="count"><%= produto.getQuantidadeAvaliacoesNota2() %></div>
                </li>
                <li>
                    <div>1 ESTRELAS</div>
                    <div class="percentage">
                        <div class="percentage-full" style="width: <%= produto.getBarra1Estrelas() %>%;"></div>
                    </div>
                    <div class="count"><%= produto.getQuantidadeAvaliacoesNota1() %></div>
                </li>
            </ul>
        </div>
    </div>

    <!-- Coluna da direita (avalia��es em si) -->
    <div class="right-rating">

        <%
            for (AvaliacaoProdutoListDTO avaliacao : avaliacoes) {
        %>
        <!-- Avalia��o do cliente -->
        <div class="review-star">
            <%
                for (int r = 0; r < Integer.valueOf(avaliacao.getAvaliacao()); r++) {
            %>
            &#x2605;
            <%
                }
            %>
            <div class="review-date"><%= avaliacao.getAvaliacaoDataSimples()%></div>
        </div>
        <div class="review-title"><%= avaliacao.getAvaliacaoTitulo() %><div class="review-text"><%= avaliacao.getAvaliacaoDescricao() %></div>
        </div>
        <div class="review-name"><%= avaliacao.getAvaliador() %></div>
        <%
            }
        %>

        <% if (produto.getAvaliacaoDadaPeloUsuario().equals("")) { %>
        <!-- Bot�o para avaliar o produto -->
        <div class="review-btn">
            <a href="avaliacao?produtoId=<%= produto.getId() %>">Adicionar uma avalia��o</a>
        </div>
        <% }%>
    </div>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp"></jsp:include>
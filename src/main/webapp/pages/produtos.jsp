<%-- 
    Document   : produtos
    Created on : 02/10/2019, 00:11:02
    Author     : HP
--%>
<%@page import="br.uff.loja.core.dtos.ProdutoListaDTO"%>
<%@page import="br.uff.loja.core.dtos.PaginateDTO"%>
<%@page import="java.util.List"%>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Produtos"/>
</jsp:include>
<%
    PaginateDTO<List<ProdutoListaDTO>> produtos = new PaginateDTO<List<ProdutoListaDTO>>();
    if (request.getAttribute("produtos") != null) {
        produtos = (PaginateDTO<List<ProdutoListaDTO>>) request.getAttribute("produtos");
    }
%>
<form method="post" action="produtos" id="frmProdutos">
    <!-- Container principal -->
    <div class="products-main">

        <!-- Container dos filtros -->
        <div class="products-filter">
            <!-- Filtro das categorias -->
            <div class="products-item-filter">
                <p>Nome ou Descri��o</p>
                <input name="pesquisa" value="${pesquisa}" type="search" placeholder="Buscar..." onchange="document.getElementById('frmProdutos').submit()">
            </div>
            <div class="products-item-filter">
                <p>Categorias</p>
                <input ${playstation} onchange="document.getElementById('frmProdutos').submit()" name="category" id="playstation" type="checkbox" value="playstation"><label for="playstation">Playstation</label><br>
                <input ${xbox} onchange="document.getElementById('frmProdutos').submit()" name="category" id="xbox" type="checkbox" value="xbox"><label for="xbox">Xbox</label><br>
                <input ${wii} onchange="document.getElementById('frmProdutos').submit()" name="category" id="wii" type="checkbox" value="wii"><label for="wii">Wii</label><br>
            </div>
            <!-- Fitro das subcategorias -->
            <div class="products-item-filter">
                <p>Subcategorias</p>
                <input ${consoles} onchange="document.getElementById('frmProdutos').submit()" name="subCategory" type="checkbox" value="consoles" id="consoles"><label for="consoles">Consoles</label><br>
                <input ${jogos} onchange="document.getElementById('frmProdutos').submit()" name="subCategory" type="checkbox" value="jogos" id="jogos"><label for="jogos">Jogos</label><br>
                <input ${acessorios} onchange="document.getElementById('frmProdutos').submit()" name="subCategory" type="checkbox" id="acessorios" value="acessorios"><label for="acessorios">Acess�rios</label><br>
            </div>
            <!-- Filtro dos pre�os -->
            <div class="products-item-filter">
                <p>Pre�os</p>
                <label>Valor M�nimo (R$)</label>
                <div class="products-range">
                    <input value="${priceMin}" onchange="verifica_precos()" type="range" min="0" max="5000" step="100" oninput="display_min.value=value" onchange="display_min.value = value">
                    <input value="${priceMin}" name="price_min" type="number" readonly id="display_min"/>
                </div>
                <label>Valor M�ximo (R$)</label>
                <div  class="products-range">
                    <input value="${priceMax}" onchange="verifica_precos()" type="range" min="0" max="5000" step="100" oninput="display_max.value=value" onchange="display_max.value = value">
                    <input value="${priceMax}" name="price_max" type="number" readonly id="display_max"/>
                </div>
            </div>
        </div>

        <!-- Container dos produtos -->
        <div class="products-page">
            <% if (produtos.getDados().size() < 1) { %>
            <h3>O filtro escolhido n�o retornou nenhum produto. Mas n�o desista, tente com outro.</h3>
            <%
            } else {
            %>
            <div class="products-container">
                <%
                    for(ProdutoListaDTO produto : produtos.getDados()){
                %>
                <div class="products-item">
                    <a href="produto?produtoId=<%= produto.getId() %>">
                        <div class="products-cart">Ver Detalhes</div>
                        <img src="<%= produto.getImagem() %>">
                        <div class="products-title"><%= produto.getNome() %></div>
                        <div class="products-details"><%= produto.getCategoria() %></div>
                        <div class="products-price">R$<%= produto.getPreco() %></div>
                    </a>
                </div>
                <%
                    }
                %>
            </div>
            <!-- P�ginas -->
            <div class="products-paging">
                <% if (produtos.getPaginaAtual() > 1) {%>
                <button class="products-prev" name="action" value="ant">&#8249;</button>
                <% }%>
                <span><%= produtos.getPaginaAtual() %></span>
                <% if (produtos.getPaginaAtual() < produtos.getUltimaPagina()) { %>
                <button class="products-next" name="action" value="prox">&#8250;</button>
                <% }%>
            </div>
            <%
                }
            %>
        </div>
    </div>
</form>
<script>
    function verifica_precos() {
        var price_min = document.getElementById('display_min').value;
        var price_max = document.getElementById('display_max').value;
        if (parseInt(price_min) >= parseInt(price_max)) {
            alert("Valor m�nimo(R$" + price_min + ") n�o pode ser igual ou maior que o valor m�ximo(R$" + price_max + ")!");
            return false;
        } else {
            document.getElementById('frmProdutos').submit();
            return true;
        }
    }
</script>
<!-- Footer -->
<jsp:include page="footer.jsp"></jsp:include>
package br.uff.loja.infrastructure.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import br.uff.loja.core.dtos.EnderecoDTO;
import br.uff.loja.core.exceptions.LojaException;
import br.uff.loja.core.interfaces.data.IEnderecoData;
import br.uff.loja.infrastructure.database.MySQLDAO;

public class EnderecoData implements IEnderecoData {
    private final MySQLDAO mysqlDAO;

    public EnderecoData() {
        this.mysqlDAO = new MySQLDAO();
    }

    @Override
    public EnderecoDTO encontraEnderecoPorId(Integer id) throws LojaException {
        try {
            Object[] bind = {id};
            List<HashMap<String, Object>> retorno = this.mysqlDAO.dbCarrega("SELECT id, name AS nome, user_id AS usuarioId, zipcode AS cep, address AS logradouro, city AS cidade, state AS estado, country AS pais FROM address WHERE id=?", bind);
            return new EnderecoDTO(retorno.get(0));
        } catch (Exception e) {
            throw new LojaException("Falha ao Recuperar o Endereço de id: " + id + ". (" + e.getMessage() + ")");
        } finally {
            this.mysqlDAO.destroyDb();
        }
    }

    @Override
    public Integer excluiEnderecoPorId(Integer id) throws LojaException {
        try {
            Object[] bind = {id};
            return this.mysqlDAO.dbGrava("DELETE FROM address WHERE id=?", bind, false);
        } catch (Exception e) {
            throw new LojaException("Falha ao Excluir o Endereço de id: " + id + ". (" + e.getMessage() + ")");
        } finally {
            this.mysqlDAO.destroyDb();
        }
    }

    @Override
    public Integer atualizaEnderecoPorId(Integer id, EnderecoDTO endereco) throws LojaException {
        try {
            Object[] bind = {endereco.getNome(),endereco.getCep(),endereco.getLogradouro(),endereco.getCidade(),endereco.getEstado(),endereco.getCidade(),endereco.getId()};
            return this.mysqlDAO.dbGrava("UPDATE address SET name=?, zipcode=?, address=?, city=?, state=?, country=? WHERE id=?", bind, false);
        } catch (Exception e) {
            throw new LojaException("Falha ao Atualizar o Endereço de id: " + id + ". (" + e.getMessage() + ")");
        } finally {
            this.mysqlDAO.destroyDb();
        }
    }

    @Override
    public Integer insereEndereco(EnderecoDTO endereco) throws LojaException {
        try {
            Object[] bind = {endereco.getNome(),endereco.getUsuarioId(),endereco.getCep(),endereco.getLogradouro(),endereco.getCidade(),endereco.getEstado(),endereco.getCidade()};
            return this.mysqlDAO.dbGrava("INSERT INTO address (name,user_id,zipcode,address,city,state,country) VALUES (?,?,?,?,?,?,?)", bind, false);
        } catch (Exception e) {
            throw new LojaException("Falha ao Inserir o Endereço de para o Usuário de id: " + endereco.getUsuarioId() + ". (" + e.getMessage() + ")");
        } finally {
            this.mysqlDAO.destroyDb();
        }
    }

    @Override
    public List<EnderecoDTO> listaEnderecosPorUsuarioId(Integer usuarioId) throws LojaException {
        try {
            Object[] bind = {usuarioId};
            List<HashMap<String, Object>> retornoDesformatado = this.mysqlDAO.dbCarrega("SELECT id, name AS nome, user_id AS usuarioId, zipcode AS cep, address AS logradouro, city AS cidade, state AS estado, country AS pais FROM address WHERE user_id=?", bind);
            List<EnderecoDTO> retornoFormatado = new ArrayList<>();
            retornoDesformatado.forEach(endereco -> retornoFormatado.add(new EnderecoDTO(endereco)));
            return retornoFormatado;
        } catch (Exception e) {
            throw new LojaException("Falha a Lista de Endereços para o usuário de id: " + usuarioId + ". (" + e.getMessage() + ")");
        } finally {
            this.mysqlDAO.destroyDb();
        }
    }
    
}

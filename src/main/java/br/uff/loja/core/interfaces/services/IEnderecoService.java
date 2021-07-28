package br.uff.loja.core.interfaces.services;

import java.util.List;

import br.uff.loja.core.dtos.EnderecoDTO;

public interface IEnderecoService {
    public EnderecoDTO encontraEnderecoPorId(Integer id);
    public Integer excluiEnderecoPorId(Integer id);
    public Integer atualizaEnderecoPorId(Integer id, EnderecoDTO endereco);
    public Integer insereEndereco(EnderecoDTO endereco);
    public List<EnderecoDTO> listaEnderecosPorUsuarioId(Integer usuarioId);
}

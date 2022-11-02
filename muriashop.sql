-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.7.36 - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para muriaeshop-homologacao
CREATE DATABASE IF NOT EXISTS `muriaeshop-homologacao` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `muriaeshop-homologacao`;

-- Copiando estrutura para tabela muriaeshop-homologacao.cidade
CREATE TABLE IF NOT EXISTS `cidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uf_id` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `codIBGE` varchar(7) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uf_id_nome` (`uf_id`,`nome`),
  CONSTRAINT `FK1_cidade_uf_id` FOREIGN KEY (`uf_id`) REFERENCES `uf` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.departamento
CREATE TABLE IF NOT EXISTS `departamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  `statusRegistro` int(11) NOT NULL DEFAULT '1' COMMENT '1=Ativo;2=Inativo',
  `imagem` varchar(150) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.formapagamento
CREATE TABLE IF NOT EXISTS `formapagamento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(60) NOT NULL,
  `tipo` int(11) NOT NULL COMMENT '1=Dinheiro;2=Pix;3=Boleto',
  `statusRegistro` int(11) NOT NULL DEFAULT '1' COMMENT '1=Ativo;2=Inativo',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.frete
CREATE TABLE IF NOT EXISTS `frete` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL DEFAULT '0',
  `valor` decimal(14,2) NOT NULL,
  `statusRegistro` int(11) NOT NULL DEFAULT '1' COMMENT '1=Ativo;2=Inativo',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.pedidovenda
CREATE TABLE IF NOT EXISTS `pedidovenda` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) NOT NULL,
  `formapagamento_id` int(11) NOT NULL,
  `frete_id` int(11) NOT NULL,
  `vlrProdutos` decimal(14,2) DEFAULT NULL,
  `vlrFrete` decimal(14,2) DEFAULT NULL,
  `vlrTotal` decimal(14,2) DEFAULT NULL,
  `statusRegistro` int(11) NOT NULL DEFAULT '1' COMMENT '2=Aguardando Aprovação Pagamento;3=Pagamento Aprovado;4=Em Preparação;5=Em Transito;9=Pedido Entregue',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_pedidovenda_cliente_id` (`cliente_id`),
  KEY `FK2_pedidovenda_formapagamento_id` (`formapagamento_id`),
  KEY `FK3_pedidovenda_frete_id` (`frete_id`),
  CONSTRAINT `FK1_pedidovenda_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_pedidovenda_formapagamento_id` FOREIGN KEY (`formapagamento_id`) REFERENCES `formapagamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK3_pedidovenda_frete_id` FOREIGN KEY (`frete_id`) REFERENCES `frete` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.pedidovendaenderecoentrega
CREATE TABLE IF NOT EXISTS `pedidovendaenderecoentrega` (
  `pedidovenda_id` int(11) NOT NULL,
  `logradouro` varchar(60) NOT NULL DEFAULT '',
  `numero` varchar(10) NOT NULL DEFAULT '',
  `complemento` varchar(20) NOT NULL DEFAULT '',
  `bairro` varchar(40) NOT NULL DEFAULT '',
  `cep` varchar(8) NOT NULL,
  `cidade_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`pedidovenda_id`),
  KEY `FK1_pedidovendaenderecoentrega_cidade_id` (`cidade_id`),
  CONSTRAINT `FK1_pedidovendaenderecoentrega_cidade_id` FOREIGN KEY (`cidade_id`) REFERENCES `cidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.pedidovendaitem
CREATE TABLE IF NOT EXISTS `pedidovendaitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pedidovenda_id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `qtde` decimal(14,3) NOT NULL,
  `vlrUnitario` decimal(14,3) NOT NULL,
  `vlrTotal` decimal(14,3) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_pedidovendaitem_pedidovenda_id` (`pedidovenda_id`),
  KEY `FK2_pedidovendaitem_produto_id` (`produto_id`),
  CONSTRAINT `FK1_pedidovendaitem_pedidovenda_id` FOREIGN KEY (`pedidovenda_id`) REFERENCES `pedidovenda` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_pedidovendaitem_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.pedidovendastatus
CREATE TABLE IF NOT EXISTS `pedidovendastatus` (
  `pedidovenda_id` int(11) NOT NULL,
  `statusRegistro` int(11) NOT NULL DEFAULT '1' COMMENT '2=Aguardando Aprovação Pagamento;3=Pagamento Aprovado;4=Em Preparação;5=Em Transito;9=Pedido Entregue',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  KEY `FK1_pedidovendastatus_pedidovenda_id` (`pedidovenda_id`),
  CONSTRAINT `FK1_pedidovendastatus_pedidovenda_id` FOREIGN KEY (`pedidovenda_id`) REFERENCES `pedidovenda` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.pessoa
CREATE TABLE IF NOT EXISTS `pessoa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) DEFAULT NULL,
  `ddd1` varchar(2) DEFAULT NULL,
  `celular1` varchar(9) DEFAULT NULL,
  `statusRegistro` int(11) NOT NULL DEFAULT '1' COMMENT '1=Ativo;2=Inativo',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.pessoacliente
CREATE TABLE IF NOT EXISTS `pessoacliente` (
  `pessoa_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`pessoa_id`),
  CONSTRAINT `FK1_pessoacliente_pessoa_id` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.pessoaendereco
CREATE TABLE IF NOT EXISTS `pessoaendereco` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pessoa_id` int(11) NOT NULL,
  `tipoEndereco` int(11) NOT NULL COMMENT '1=Cobrança;2=Endereço Entrega',
  `logradouro` varchar(60) NOT NULL DEFAULT '',
  `numero` varchar(10) NOT NULL DEFAULT '',
  `complemento` varchar(20) NOT NULL DEFAULT '',
  `bairro` varchar(40) NOT NULL DEFAULT '',
  `cep` varchar(8) NOT NULL,
  `cidade_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_pessoaendereco_pessoa_id` (`pessoa_id`),
  KEY `FK2_pessoaendereco_cidade_id` (`cidade_id`),
  CONSTRAINT `FK1_pessoaendereco_pessoa_id` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_pessoaendereco_cidade_id` FOREIGN KEY (`cidade_id`) REFERENCES `cidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.pessoafisica
CREATE TABLE IF NOT EXISTS `pessoafisica` (
  `pessoa_id` int(11) NOT NULL,
  `cpf` varchar(11) NOT NULL,
  `dataNascimento` date NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`pessoa_id`),
  CONSTRAINT `FK1_pessoafisica_pessoa_id` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.produto
CREATE TABLE IF NOT EXISTS `produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL DEFAULT '',
  `detalhamento` text,
  `departamento_id` int(11) NOT NULL,
  `precoVenda` decimal(14,2) NOT NULL,
  `statusRegistro` int(11) DEFAULT NULL COMMENT '1=Ativo;2=Inativo;3=Indisponível',
  `largura` int(11) DEFAULT NULL,
  `altura` int(11) DEFAULT NULL,
  `profundidade` int(11) DEFAULT NULL,
  `pesoBruto` decimal(14,3) DEFAULT NULL,
  `totalCurtida` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_produto_departamento_id` (`departamento_id`),
  CONSTRAINT `FK1_produto_departamento_id` FOREIGN KEY (`departamento_id`) REFERENCES `departamento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.produtocomentario
CREATE TABLE IF NOT EXISTS `produtocomentario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `produto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `statusRegistro` int(11) NOT NULL DEFAULT '1' COMMENT '1=Ativo;2=Inativo',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_produtocomentario_produto_id` (`produto_id`),
  KEY `FK2_produtocomentario_usuario_id` (`usuario_id`),
  CONSTRAINT `FK1_produtocomentario_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_produtocomentario_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.produtocurtida
CREATE TABLE IF NOT EXISTS `produtocurtida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `produto_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `produto_id_usuario_id` (`produto_id`,`usuario_id`),
  KEY `FK2_produtocurtida_usuario_id` (`usuario_id`),
  CONSTRAINT `FK1_produtocurtida_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK2_produtocurtida_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.produtoimagem
CREATE TABLE IF NOT EXISTS `produtoimagem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomeArquivo` varchar(120) NOT NULL DEFAULT '',
  `produto_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nomeArquivo` (`nomeArquivo`),
  KEY `FK1_produtoimagem_produto_id` (`produto_id`),
  CONSTRAINT `FK1_produtoimagem_produto_id` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.uf
CREATE TABLE IF NOT EXISTS `uf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sigla` char(2) NOT NULL,
  `descricao` varchar(60) NOT NULL,
  `regiao` int(10) unsigned NOT NULL,
  `codIBGE` varchar(2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sigla` (`sigla`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela muriaeshop-homologacao.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) DEFAULT NULL,
  `nivel` int(11) NOT NULL COMMENT '1=Administrador;11=Cliente',
  `statusRegistro` int(11) NOT NULL COMMENT '1=Ativo;2=Inativo',
  `email` varchar(150) NOT NULL,
  `senha` varchar(250) NOT NULL,
  `pessoa_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_usuario_pessoa_id` (`pessoa_id`),
  CONSTRAINT `FK1_usuario_pessoa_id` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

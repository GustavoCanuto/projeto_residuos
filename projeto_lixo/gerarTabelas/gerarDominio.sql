   
 INSERT INTO tb_tipo_material (id, nome)
VALUES
    (1, 'sintetico'),
    (2, 'organico');
    
   INSERT INTO tb_tipo_destino (id, nome, descricao)
VALUES
    (1, 'Aterro', 'Local destinado ao descarte de resíduos sólidos.'),
    (2, 'Centro de Reciclagem', 'Local destinado ao processamento e separação de materiais recicláveis.'),
    (3, 'Incineradora', 'Local onde os resíduos são queimados para redução de volume e eliminação de patógenos.'),
    (4, 'Compostagem', 'Processo de decomposição de matéria orgânica para produção de adubo.'),
    (5, 'Descarte em Rios ou Oceanos', 'Infelizmente ainda uma prática comum, mas extremamente prejudicial ao meio ambiente.'),
    (6, 'Reutilização', 'Processo de dar nova vida a objetos ou materiais, evitando o descarte.'),
    (7, 'Outro', 'Tipo de destino não especificado nas opções anteriores.');
    
   INSERT INTO tb_tipo_lixo (id, nome)
VALUES
    (1, 'residencial'),
    (2, 'comercial'),
    (3, 'hospitalar'),
    (4, 'industrial'),
    (5, 'agrícola'),
    (6, 'eletrônico'),
    (7, 'radioativo'),
    (8, 'construção civil'),
    (9, 'verde'),
    (10, 'outro');
    
INSERT INTO tb_material (id, nome, tempo_decomposicao, fk_tipo_material)
VALUES
    (1, 'Plástico', '1000 anos', 1),
    (2, 'Vidro', 'Não se decompõe', 1),
    (3, 'Papel', '2-6 semanas', 1),
    (4, 'Metal', 'Não se decompõe', 1),
    (5, 'Alumínio', '200-500 anos', 1),
    (6, 'Orgânico', '2-6 semanas', 2),
    (7, 'Madeira', '10-12 anos', 2),
    (8, 'Alimentos', '2-6 semanas', 2);
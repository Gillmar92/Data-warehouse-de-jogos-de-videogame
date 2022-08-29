PGDMP     /    /                z            vendas_games    14.5    14.5 0    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16394    vendas_games    DATABASE     l   CREATE DATABASE vendas_games WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE vendas_games;
                postgres    false                        3079    16448 	   btree_gin 	   EXTENSION     =   CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;
    DROP EXTENSION btree_gin;
                   false            �           0    0    EXTENSION btree_gin    COMMENT     R   COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';
                        false    2                        3079    16884    pg_trgm 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;
    DROP EXTENSION pg_trgm;
                   false            �           0    0    EXTENSION pg_trgm    COMMENT     e   COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';
                        false    3            \           1255    16972    insere_jogo()    FUNCTION     "  CREATE FUNCTION public.insere_jogo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO venda_jogo_00_06 (SELECT ga.jogo,a.ano_release,new.vendas_milhoes FROM game as ga,ano_lancamento as a, vendas_jogos as vj
                                   WHERE ga.cod_jogo = new.cod_jogo AND
                                          a.ano_release = new.ano_release AND
                                          a.ano_release BETWEEN 2000 AND 2006
                                    group by ga.jogo,a.ano_release);
RETURN NEW;
END;
$$;
 $   DROP FUNCTION public.insere_jogo();
       public          postgres    false            �            1259    16406    ano_lancamento    TABLE     I   CREATE TABLE public.ano_lancamento (
    ano_release integer NOT NULL
);
 "   DROP TABLE public.ano_lancamento;
       public         heap    postgres    false            �           0    0    TABLE ano_lancamento    ACL     �   GRANT SELECT ON TABLE public.ano_lancamento TO analista_vendas;
GRANT SELECT,UPDATE ON TABLE public.ano_lancamento TO gerente_vendas;
          public          postgres    false    213            �            1259    16401    game    TABLE     �   CREATE TABLE public.game (
    cod_jogo integer NOT NULL,
    jogo character varying(50),
    genero character varying(15),
    plataforma character varying(20)
);
    DROP TABLE public.game;
       public         heap    postgres    false            �           0    0 
   TABLE game    ACL     r   GRANT SELECT ON TABLE public.game TO analista_vendas;
GRANT SELECT,UPDATE ON TABLE public.game TO gerente_vendas;
          public          postgres    false    212            �            1259    16443    venda_jogo_00_06    TABLE     �   CREATE TABLE public.venda_jogo_00_06 (
    jogo character varying(50),
    genero character varying(15),
    ano_release integer,
    vendas_milhoes numeric
);
 $   DROP TABLE public.venda_jogo_00_06;
       public         heap    postgres    false            �           0    0    TABLE venda_jogo_00_06    ACL     �   GRANT SELECT ON TABLE public.venda_jogo_00_06 TO analista_vendas;
GRANT SELECT,UPDATE ON TABLE public.venda_jogo_00_06 TO gerente_vendas;
          public          postgres    false    217            �            1259    16395    vendas    TABLE     U  CREATE TABLE public.vendas (
    cod_venda integer NOT NULL,
    pais character varying(6),
    continente character varying(25),
    CONSTRAINT continente_check CHECK (((continente)::text = ANY ((ARRAY['America do Norte'::character varying, 'Europa'::character varying, 'Asia'::character varying, 'Outro'::character varying])::text[])))
);
    DROP TABLE public.vendas;
       public         heap    postgres    false            �           0    0    TABLE vendas    ACL     v   GRANT SELECT ON TABLE public.vendas TO analista_vendas;
GRANT SELECT,UPDATE ON TABLE public.vendas TO gerente_vendas;
          public          postgres    false    211            �            1259    16433    vendas_85_00    TABLE     �   CREATE TABLE public.vendas_85_00 (
    plataforma character varying(20),
    genero character varying(15),
    ano_release integer,
    vendas_milhoes numeric
);
     DROP TABLE public.vendas_85_00;
       public         heap    postgres    false            �           0    0    TABLE vendas_85_00    ACL     �   GRANT SELECT ON TABLE public.vendas_85_00 TO analista_vendas;
GRANT SELECT,UPDATE ON TABLE public.vendas_85_00 TO gerente_vendas;
          public          postgres    false    215            �            1259    16411    vendas_jogos    TABLE     �   CREATE TABLE public.vendas_jogos (
    cod_venda integer NOT NULL,
    cod_jogo integer NOT NULL,
    ano_release integer NOT NULL,
    vendas_milhoes numeric
);
     DROP TABLE public.vendas_jogos;
       public         heap    postgres    false            �           0    0    TABLE vendas_jogos    ACL     �   GRANT SELECT ON TABLE public.vendas_jogos TO analista_vendas;
GRANT SELECT,UPDATE ON TABLE public.vendas_jogos TO gerente_vendas;
          public          postgres    false    214            �            1259    16438    vendas_lugar_06    TABLE     �   CREATE TABLE public.vendas_lugar_06 (
    pais character varying(6),
    continente character varying(25),
    ano_release integer,
    vendas_milhoes numeric
);
 #   DROP TABLE public.vendas_lugar_06;
       public         heap    postgres    false            �           0    0    TABLE vendas_lugar_06    ACL     �   GRANT SELECT ON TABLE public.vendas_lugar_06 TO analista_vendas;
GRANT SELECT,UPDATE ON TABLE public.vendas_lugar_06 TO gerente_vendas;
          public          postgres    false    216            �            1259    16976    visao_imprensa    TABLE     �   CREATE TABLE public.visao_imprensa (
    jogo character varying(50),
    genero character varying(15),
    plataforma character varying(20),
    ano_release integer,
    round numeric
);
 "   DROP TABLE public.visao_imprensa;
       public         heap    postgres    false            �           0    0    TABLE visao_imprensa    ACL     �   GRANT SELECT ON TABLE public.visao_imprensa TO assessor_imprensa;
GRANT SELECT,UPDATE ON TABLE public.visao_imprensa TO gerente_vendas;
          public          postgres    false    218            �          0    16406    ano_lancamento 
   TABLE DATA           5   COPY public.ano_lancamento (ano_release) FROM stdin;
    public          postgres    false    213   �5       �          0    16401    game 
   TABLE DATA           B   COPY public.game (cod_jogo, jogo, genero, plataforma) FROM stdin;
    public          postgres    false    212   &6       �          0    16443    venda_jogo_00_06 
   TABLE DATA           U   COPY public.venda_jogo_00_06 (jogo, genero, ano_release, vendas_milhoes) FROM stdin;
    public          postgres    false    217   �;       �          0    16395    vendas 
   TABLE DATA           =   COPY public.vendas (cod_venda, pais, continente) FROM stdin;
    public          postgres    false    211   �>       �          0    16433    vendas_85_00 
   TABLE DATA           W   COPY public.vendas_85_00 (plataforma, genero, ano_release, vendas_milhoes) FROM stdin;
    public          postgres    false    215   �B       �          0    16411    vendas_jogos 
   TABLE DATA           X   COPY public.vendas_jogos (cod_venda, cod_jogo, ano_release, vendas_milhoes) FROM stdin;
    public          postgres    false    214   �D       �          0    16438    vendas_lugar_06 
   TABLE DATA           X   COPY public.vendas_lugar_06 (pais, continente, ano_release, vendas_milhoes) FROM stdin;
    public          postgres    false    216   N       �          0    16976    visao_imprensa 
   TABLE DATA           V   COPY public.visao_imprensa (jogo, genero, plataforma, ano_release, round) FROM stdin;
    public          postgres    false    218   �N       A           2606    16410    ano_lancamento ano_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.ano_lancamento
    ADD CONSTRAINT ano_pk PRIMARY KEY (ano_release);
 ?   ALTER TABLE ONLY public.ano_lancamento DROP CONSTRAINT ano_pk;
       public            postgres    false    213            ?           2606    16405    game jogo_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.game
    ADD CONSTRAINT jogo_pk PRIMARY KEY (cod_jogo);
 6   ALTER TABLE ONLY public.game DROP CONSTRAINT jogo_pk;
       public            postgres    false    212            =           2606    16400    vendas venda_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT venda_pk PRIMARY KEY (cod_venda);
 9   ALTER TABLE ONLY public.vendas DROP CONSTRAINT venda_pk;
       public            postgres    false    211            C           2606    16417    vendas_jogos vendas_jogos_pk 
   CONSTRAINT     x   ALTER TABLE ONLY public.vendas_jogos
    ADD CONSTRAINT vendas_jogos_pk PRIMARY KEY (cod_venda, cod_jogo, ano_release);
 F   ALTER TABLE ONLY public.vendas_jogos DROP CONSTRAINT vendas_jogos_pk;
       public            postgres    false    214    214    214            D           1259    16967    idxano    INDEX     F   CREATE INDEX idxano ON public.vendas_85_00 USING btree (ano_release);
    DROP INDEX public.idxano;
       public            postgres    false    215            G           1259    16969    idxcontinente    INDEX     M   CREATE INDEX idxcontinente ON public.vendas_lugar_06 USING gin (continente);
 !   DROP INDEX public.idxcontinente;
       public            postgres    false    2    2    2    2    2    2    216            E           1259    16966 	   idxgenero    INDEX     B   CREATE INDEX idxgenero ON public.vendas_85_00 USING gin (genero);
    DROP INDEX public.idxgenero;
       public            postgres    false    2    2    2    2    2    2    215            I           1259    16971    idxgenerogame    INDEX     J   CREATE INDEX idxgenerogame ON public.venda_jogo_00_06 USING gin (genero);
 !   DROP INDEX public.idxgenerogame;
       public            postgres    false    2    2    2    2    2    2    217            J           1259    16970    idxjogotrgm    INDEX     Z   CREATE INDEX idxjogotrgm ON public.venda_jogo_00_06 USING gin (jogo public.gin_trgm_ops);
    DROP INDEX public.idxjogotrgm;
       public            postgres    false    3    3    3    3    3    3    3    3    3    3    3    3    217            H           1259    16968    idxpais    INDEX     A   CREATE INDEX idxpais ON public.vendas_lugar_06 USING gin (pais);
    DROP INDEX public.idxpais;
       public            postgres    false    216    2    2    2    2    2    2            F           1259    16965    idxplataforma    INDEX     J   CREATE INDEX idxplataforma ON public.vendas_85_00 USING gin (plataforma);
 !   DROP INDEX public.idxplataforma;
       public            postgres    false    215    2    2    2    2    2    2            N           2620    16973    vendas_jogos novo_jogo    TRIGGER     q   CREATE TRIGGER novo_jogo AFTER INSERT ON public.vendas_jogos FOR EACH ROW EXECUTE FUNCTION public.insere_jogo();
 /   DROP TRIGGER novo_jogo ON public.vendas_jogos;
       public          postgres    false    214    348            M           2606    16428    vendas_jogos ano_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vendas_jogos
    ADD CONSTRAINT ano_fk FOREIGN KEY (ano_release) REFERENCES public.ano_lancamento(ano_release) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.vendas_jogos DROP CONSTRAINT ano_fk;
       public          postgres    false    214    3393    213            K           2606    16418    vendas_jogos cod_venda_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vendas_jogos
    ADD CONSTRAINT cod_venda_fk FOREIGN KEY (cod_venda) REFERENCES public.vendas(cod_venda) ON DELETE CASCADE;
 C   ALTER TABLE ONLY public.vendas_jogos DROP CONSTRAINT cod_venda_fk;
       public          postgres    false    211    214    3389            L           2606    16423    vendas_jogos jogo_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.vendas_jogos
    ADD CONSTRAINT jogo_fk FOREIGN KEY (cod_jogo) REFERENCES public.game(cod_jogo) ON DELETE CASCADE;
 >   ALTER TABLE ONLY public.vendas_jogos DROP CONSTRAINT jogo_fk;
       public          postgres    false    3391    212    214            �   R   x��� 1�����^��:6�12��T�-���)n�t�`2.
g�o�V8�Y�� L��n�����3��
�      �   j  x��W�r�6}��}�Ny��M�lŵkB�q:}A(��"4 �D��~G��	R�d�3�I �{��ő�8.����B�5���ue՞J�@$�J��Zr��B�Ї�L��y{G�°}$9+^�#����#-�s$DK��;Q�����+^Q�Qpz	��ŕ^�'�$+Ѳ����i�>�o��d�u�I��>=�2o3HOﮫ9�`ֺ�W���
�c#���A�u�V(Z��+ �vle�0�]���<ka2/�#�;2ƿ��c\����4Wx��JUIZ�bj}�#G��ڝ�C5h���$�
?m�Ψ���h��e,3_/IFK&8#�+II٭����b�'!���43�y�����t��ꯟE%�y
��-1��u5n�{�m�|t�-)��F�l�9}�t	��z������ހ���O`��r�gLl����A���Q���&GZ��=q�&�AHj��5c���)���c�O��)�Һ�T��v�<���4o�l��4#�c���JtN+*�X"���i0��������r.���XF8^�-�7�^���|o�.?��^�e�������#6/G\>���?<���_Ǐ~fm�B�6��hC�7٤c��B'�QB�#�Q0�G7�u��1�����0(g�4H*��?��A���9f�M	A&0���-é��=�bL� �D=}Gu��H��0J�=�Eś��dg�u�z��Wb+y��rF�P���B��yA8�~^P�;�oz4D��B<��!��FF�w��i�Vv]n�]`E���j�C���;C�?*�,���t��e��,GL8��z�5�����@{�V䞒�BR:@zG�Y"�5G�F�j4s"�Y�`H�k���I䟱'�_�Sat��atd�0�Su�@�.@W7�P�<�g�V�u���*�O��z?��_��//��L{bF�1�'��\[z�w.Ù �&#j�j0L������F�A��?f�q� ����u&%˺����4���?�-�=H��1n�����l�l�N������k���qj�ӻ ���8_�]�ĵ�N�w�	��<�T��Z�I`�#��@�v�G7\�-	l��=�bh��LFH�2������P��]/�3�6nJ�2/X���
�?��n�.Ȏlo� =84�J|E��t-E��o8��F"I�J9%��AK�_>��u^^���=ˣ�&m���,G�%�	�g_��6�8SB2ڳ�K�m�w`�k��F�1e�A��=}�_0z�ߔ��?�fA��'��m��4lh�4La���3@�,�8���
�ҕlK5�����,>�8��)���\�>����������iz��{c?�R�<��w��Z�      �   �  x��VQo�0~�_�?P�6�@��V��5ST�e���&nk��Ȁ����L��B )R��|ߝ��[i�ҝ�e�}1B��)���6�''���S�����~���)��j�.�)���d�l�� ��x2��
<�5�q\��{o�������(�$0���cP��R��	��
h�;{瑰�N	N��q�����|��Dש� �:9��h�9�<�1sL�3h�o��7��U=�h^�f�R��y��J�|}T�A
F�	���t�F����/j��?Le��)|:�JU ��w�)��M0��\�	���ښ]k	_�O��K%m�=�L]��~�^q�s,�8�D6�T�Ծ�oz�Е.���f�J����u��`��𓩫�c`���_����^�U�@���I!��hq�`,��(~/K�fha�:T'��U�����ԡ.���T2�����UC�=VV[���_�;�n�G
>B:`;O�KpܪHtww�(�Z\��;PQ�g�P��Yu-w��������Jg�26۴F[=���(qU0� ��U�F�9t� ��L���>3iv�x�{��W���*��^R�+���$"��4��7�:��[��$�~soJ/}A�U~��A�K_�)�=
��� N��},�7:��y)�=��J	u;^2 ���n����ب����從m(-�ժ�Z�i�@<˫�O�'��г<��O���_dP�W      �   �  x�u�1�G��xy
��`U�pfBN�P��(0VXK��~�_�����_����O/���������}������Ϳ�����o������������__oۯ�������/'5y���{�ZN�^�R�ʿ������;�5}��Ϟ�z����ֺV�2z��y]̝�h��u�t��Z�Z���Ղj�jYWKW�mUm[Wۺ��oYU��ն����Vնu������W�}]m�j;��Um_Wۻڎj���XW{t��=��c���jT{T�Ǻ���T;�ڱ�vt�Վ�v��]�@�����jgW;Q��j����N��U�s]��j�]U�ZW��څjWU��ծ�v���M�u7�;���	[��n��'<���`��a��8<� &�P��	Q	5���PS��
Q�%�(��fh�j����� �(��vx�z����� �(���h煅%������)�`�����������I�`�������������o(	\D]Լh�E FFM�cdDe��hpF�F�FM�klDm��h�F/�O7�J����� �!�)�[����� �!�)�[����M�G��*Aɧw	&�˄O���	'�8�8�8nq<�c�c��ǃ8�8�8nq<�c�����%qqLq��x���-�qqLq��x���-�qqLq��x���-�qqLq��x���-�qqLq��x���-�qq|>m�� �!�)�[����� �!�)NZ������ N N(NZ��D\�p���d'''-NqqBq��d'''-NqqBq��dڇq!���Jl(ɥ��Vk�i/���I��A�@�P��8�	�	�I��A�@�P��8����"K�8�	�	�I��A�@�P��8�	�	�I��A�@�P��8�	�	�I��A�@�P��8�	�	�I��A�@�P��8�	�	�I��A�@�P��8�	�����������n?P�.B      �   �  x�u��n1Eך)�'%.S��.0�m7A�`8��);�X�lG��+������O��Ԋ��M��'(Fh��j�~~w�~��Coχ�!t!@\	5h�r�C�+!������NR��	�bqd�"�d^�4Ґ3#n?��`,9j����Ȼ�6+����lqn���!aKG�F�|i�z�Q��9�:4N�m�,��h�K�}�#�������H��=`���8vw+��5fg�Y����;�^�b*���N�����7e��i�u�O�V*�VY_G�ժ�|��I<R"�'@�k����������EÂ\�#䪠L��a����	@Ŏxy�V"�n�%����Mi#�ܰj�.�d� �nB�wә�������}�4Jk���[�+������x�j�ɂ��K2(P��.�$�#���D�o��َd�{:=χ��^�%du������fw�r��'��Em�۳�ni����RXAGy7����Y0��L��D&�      �   }	  x�U�[��* ����R�9�;�q\(������!����_����Z���E���Y4}�*=���Q�{���O�Sw���3vY	�g�����q�ޫ�i<s�V3�g��ZB�)M~�!����S+�gT������9{�LD�3J#jkx���=�J�	�g��NnT�"5�"=�[�c{W��vM��IO��
!�;�����yZ/���(��g�CD���Q�&d��-�S�!�%��7���zB�9FF"�YEg����c��>ۆ�P}���C��{�!�2Ӄn��Ϩ�tI�gސf�/�=˳^�7����h��g"���D�Ӭ����\:1�'��wʨ���Q-�e�1$��/�KZ.˸cm��Z�HD�Y�L@�fk�h��1�����<N"��e���3O��;��� �2%��F�gh�=��}�'�}�z��9������͜U��y;�����Tײj"�e�_�ʒD,'�*���{��X��	Y�e�2�udm<h[�Ia��v"Ǧx��&m�]����=h����lIĻ���Ļ��n<b�[C�K��=O��鞕{'bCf/#fOK���O?5�����p$�g�C�=f����~��~f"�b��4��gى���$R�j��5��`��h^�/����t�����;��gL��Ⱥ�8�gB��FV"�Qn'did���]y�yݰa {�ZaÄĐ$�|2>�m�Vþҧ���ï���gB�<F<v�D�W�ƽ�Nh��m1P{���?d�ڰ�[�O)�ֆu�@/�^db��j̨^x���[3~��WB����N�F�$z�#8��6�Ⱥ���c����	� �Mw��or�.A����Ej|5�Tj�'��Wpd [���9?ȓK��)����=�'�g��d�JF �@ⅡaJ]Q��[̈́�4��@�m$�e��l�K�7K�3��@���@�w�kbc�Ц~YoA���7"N}Sܗ:��\w�z����B��:�
���eM�A<��bM�BH�!�~Ȫ[C�������.����H4Pw�6,H���2�z_�N�v�˿��T�q@��l�l�qi�Ɔ����<������i��j���l��o$��ߒ�D�O��2h�QUV,J���M��w�H�TҰj�[o�j K.oE����:�		���7�i��=�wO��gKT�G7��*vT9��~���.�H�p�!�}&R}��0�1Ξp(6P��$d�؎>5��?A���-W��b�*(6P�C�BT�a��Jl��L�]���Y��T��(8v��^֗����@�eJpl��	�j��ǎ~�'Opl u
�$^���^�Ɏ�3$�_w�o!(;�ݻ�y���݈[��d}�QT���~6G�����*C0l S��bQ�dg#��TPk��"6!���s�`Ǜ�>�v��퓏aǛ޶����`�Y���vB�
H	��$3���
|�R����ܝ�aU�R�a��3L[�aY"�gc�@�e�a?t<��м���R&���[���F�.%/����!OJ�H|�,�5{A�s�Ȇ�j~� �u�9o�S��|s����y��bl��7#�@l!�~�D&v��D�~��Zq)��,<���=�l �A�N"���A;�_5�F�~�6f�`qx���_W�<��v"xL�k ���y�������]�5�2��5�-�5�]��?�v#��LH��D��P����'cץ7��s�5Ps�
vd���������n���Dnq���*@���Z׻�q���I�"?Eq�zw5 "�!�nDi>��Z?t���P�s��ֵ�n�_�)n$�(��Q7�/$v�&�ޔ(jԸ�C�_+E��꽇$��R�����8�+j��˃�����n��;���Ů�*�]����~�vy+IH�:(v$��R��50��G�%j�-rŮ��-)v��FX�k�ꗫ�u��)v�߮ƾ�~�y��7��}�u�9OW#����/��A���m��\� �d �@(D�k ����o_�H~��U��L��\���QGD�b2l3��5��Z���me���S6ƈu�%���Q����Z!����t$?�?��b�pk v�[�oŭ�n�����\�(nt���R+nD	T�z��-�­�������~��&�t���'��:�X�{u�A!֯�	Lk�J]A��� j�U�~��
^=���9HB�����ߋ��{B�'^ū�8(^�+�zؚp;kd'�|[���C>z�5P��"���L<i0k�A���'oi��w�c;;Ŭg��;F.o5�T���q]1k�zѿw�b����>�����M�b�@\#(v���wǶ�U�H|W��5�P���iy��7�7nI��q+��̋�rv�k"���R��S#�P      �   �   x�}�1� ��N�X`0c�.���6C���&�OQ:�m�_ϟ<&5<�:�s�(]*u��Yp^�I]�Z�|Dd�^_�^�:�-o�Zˑ�o�m- �����?��d��2!:I�o� ��Q��ؼOAk�S�[�      �   V  x��W�r�F=_1����`+o%ʊ,�%(���e�)����;�c�ƾ��I%����ݯ����D�߾�B��ijV�S�3|W_&��c�JU���eA>�/��;-��"�T��.B������[�JEnx�O���5K����::	��HI>����Tz�<Z�aQ}�^�A%�� ^8�/>��h>-�㞓��{�
�^��ܜz�ښe��zyn�?��fنK���yϓ���0pjlx�پ�P�IJ�;��|��wy��M)~��<�4��I.mL����\B�/���U� ��	|��I���pr�OMf[��u��,�GU���:�p+�������e8���B�A���	1='V�7_���h`���A&�H��%�c�Bƺ��<z%����^���0�M���-�vsV&�H���Br��m7���!FS�� �0�Rqg�"e�Y��2��`&Z��oyR��(�q3����֠�]{̰�5lw�S=e���"0�=��Egub��՘e0�⣈c�eA£�$t�F��h_�˭�'1U>|lO���f��0��c�2H����I�-��E����f�� �TfM5n�iP�{����*b��e˵cv���l^�jKx�kX�^=��$�Q�W*��|����=�fh�^s���9k��e�VI�(�Pއ���^��ڑ�E��r�Y��˃<��NkS�9��/
h�wE�wo��@[����E9���h6PmO��QQc�Vg�)a3P�����@J2��e���d��Wi)�P52� �tV*��WBe��@��^t7l�*��������y���D���ym���	v���ׯR���J��6ޠpMs�@��c�ѳF7>���Ȃ�,�ColA�gخ���h�!���Q�Vl	$`��e�+��e��cc(h\�L������Fu���<�H���O#������xc=_�iQϏ�c���&d����uނCcZ.���j��|�Afl{�U[��(�鎧8ĆF8L�_0�b�JvmO__��0r���o�a�l���;]FFf)'׏Co0�P��)r�gP(�1ɠ�<�Ķ����lSPYoe���N��b�r����u�>��ա7:t���^ ���Z`R�<�g�Z�y,v�Jr�^���Y~���
~/?	ܤ��A}T*E��7��ag_��U�ȍ�ep�@��S�Pa%���Ɔ;�2�����0w�P^q�4���b�` �ىG[�?�6H�,�v�"��\V�KI���͛6��Pĉ��I�~�G�����:{���3Ҵ�3�@j��1�p�`���ח^`���%��6�� (�ސ�+�	�Tqי��_˓�]5��������F�o�:�4Y�|��(&�)�Ř� �ӯ %1�����W�1�����U�>��]ͧ�c� �Tf�w�F�;��N�赝��\�����J}Ge��{B���B�W�p�S��M'Qx�D�����6�	���ts���g��1C(7�w<V�;��)n��=�,"�<]@�a��lG�~#�]ӳ_���`X�Ю�K�.�\�q߻���$JUg����S*���㬬����D�W��o8?3n��Q	�gخ���������     
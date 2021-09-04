--INSERT INTO author use BookShop;
INSERT INTO author
            (NAME,
             address,
             url)
VALUES     ( 'karan Motwani',
             'Gujarat',
             'https://karanmotwani' ),
            ( 'Priyatosh Dixit',
              'Maharashtra',
              'https://PriyatoshDixit' ),
            ( 'Hamza Usmani',
              'UP',
              'https://Hamzausmani' );

INSERT INTO publisher
            (NAME,
             address,
             phone,
             url)
VALUES     ( 'Siddarth Menon',
             'kerala',
             '8275913637',
             'https://siddarthmenon' ),
            ( 'Gauri Tawde',
              'Himachal',
              '8668822108',
              'https://gauritawde' ),
            ( 'Monika Jambhale',
              'MP',
              '8275854512',
              'https://monikajambhale' );

INSERT INTO book
            (isbn,
             NAME,
             publisher_name,
             authorname,
             authoradress,
             year,
             title,
             price)
VALUES     ( '25634',
             'Subtle art',
             'Siddarth Menon',
             'karan Motwani',
             'Gujarat',
             2017,
             'life',
             300.50),
            ('25635',
             'norweign wood',
             'Gauri Tawde',
             'Priyatosh Dixit',
             'Maharashtra',
             2018,
             'story',
             400.50),
            ('25636',
             'Sleeping widow',
             'Monika Jambhale',
             'Hamza Usmani',
             'UP',
             2019,
             'History',
             500.50 );

INSERT INTO customer
            (email,
             NAME,
             phone,
             address)
VALUES     ( 'ppdhatrak@gmail.com',
             'Prajakta',
             8208049845,
             'Nashikroad' ),
            ( 'suchitkoli97@gmail.com',
              'Suchit',
              8668822108,
              'DGP nagar' ),
            ( 'jhadevesh34@gmail.com',
              'Devesh',
              7620647952,
              'Satpur' );

INSERT INTO shoppingbasket
            (customeremail)
VALUES     ('ppdhatrak@gmail.com'),
            ('suchitkoli97@gmail.com'),
            ('jhadevesh34@gmail.com');

INSERT INTO shoppingbasket_book
            (shoppingbasket_id,
             bookisbn,
             count)
VALUES     (5,
            '25634',
            11),
            (6,
             '25635',
             12),
            (7,
             '25636',
             13);

INSERT INTO warehouse
            (phone,
             adress)
VALUES     (9876543210,
            'Mumbai'),
            (9812345678,
             'Delhi'),
            (9965437897,
             'Patna');

INSERT INTO warehouse_book
            (warehouse_code,
             bookisbn,
             count)
VALUES     (1,
            '25634',
            8),
            (2,
             '25635',
             9),
            (3,
             '25636',
             7); 
CREATE TABLE `Accounts` (
  `id` varchar(45) NOT NULL,
  `AccountNumber` varchar(45) DEFAULT NULL,
  `AccountName` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `City` varchar(45) DEFAULT NULL,
  `State` varchar(45) DEFAULT NULL,
  `Consent` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

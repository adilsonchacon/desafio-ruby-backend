# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TransactionType.create(type_id:1, description: "Débito", nature: "Entrada", signal: "+")
TransactionType.create(type_id:2, description: "Boleto", nature: "Saída", signal:"-")
TransactionType.create(type_id:3, description: "Financiamento", nature: "Saída", signal:"-")
TransactionType.create(type_id:4, description: "Crédito", nature: "Entrada", signal:"+")
TransactionType.create(type_id:5, description: "Recebimento Empréstimo", nature: "Entrada", signal:"+")
TransactionType.create(type_id:6, description: "Vendas", nature: "Entrada", signal:"+")
TransactionType.create(type_id:7, description: "Recebimento TED", nature: "Entrada", signal:"+")
TransactionType.create(type_id:8, description: "Recebimento DOC", nature: "Entrada", signal:"+")
TransactionType.create(type_id:9, description: "Aluguel", nature: "Saída", signal: "-")
import 'package:flutter/material.dart';
import 'package:fast_location/src/modules/home/model/address_model.dart';

class SearchAddress extends StatefulWidget {
  final AddressModel address;

  const SearchAddress({
    super.key,
    required this.address,
  });

  @override
  State<SearchAddress> createState() => _SearchAddressState();
}

class _SearchAddressState extends State<SearchAddress> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dados da Localização",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ),
          const SizedBox(height: 15),
          _buildRow("Logradouro/Rua:", widget.address.publicPlace),
          _buildRow("Bairro/Distrito:", widget.address.neighborhood),
          if (widget.address.complement != null &&
              widget.address.complement!.isNotEmpty)
            _buildRow("Complemento:", widget.address.complement!),
          _buildRow(
              "Cidade/UF:", '${widget.address.city}/${widget.address.state}'),
          _buildRow("CEP:", widget.address.cep),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Text(value),
        ],
      ),
    );
  }
}

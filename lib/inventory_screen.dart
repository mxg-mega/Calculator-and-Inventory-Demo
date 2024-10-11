import "package:api_learn/providers/data_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventory')),
      body: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          // Show a loading indicator if data is being fetched
          if (dataProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          // Display an error message if there was an error during the API call
          if (dataProvider.errorMessage != null) {
            return Center(child: Text(dataProvider.errorMessage!));
          }

          // Display a message if the data is empty or null
          if (dataProvider.data == null || dataProvider.data!.isEmpty) {
            return Center(child: Text('No products available'));
          }

          // If data is present, display it in a ListView
          return ListView.builder(
            itemCount: dataProvider.data!.length,
            itemBuilder: (context, index) {
              final product = dataProvider.data![index];
              return ListTile(
                title: Text(product['product']), // Assuming 'product' is a key
                subtitle: Text('Price: \$${product['price']}'), // Assuming 'price' is a key
              );
            },
          );
        },
      ),
      // Floating Action Button to add a new product (optional)
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Add a test product when the button is pressed
              context.read<DataProvider>().addToInventory('New Product', 50.0);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 5,),
          FloatingActionButton(
            onPressed: () {
              // Add a test product when the button is pressed
              context.read<DataProvider>().fetchInventory();
            },
            child: Icon(Icons.refresh),
          ),
        ],
      )
    );
  }
}


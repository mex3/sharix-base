package com.example.library1;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.library1.ui.library.data.ExampleItem;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;

public class Description extends AppCompatActivity implements OnMapReadyCallback {

    private GoogleMap mMap;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_description);

        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);

        Intent intent = getIntent();
        ExampleItem exampleItem = intent.getParcelableExtra("Example Item");

        int imageRes = exampleItem.getImageResource();
        String line1 = exampleItem.getText1();
        String line2 = exampleItem.getText2();
        String line3 = exampleItem.getText3();

        setTitle(line1);

        ImageView imageView = findViewById(R.id.img_count);
        imageView.setImageResource(imageRes);

        TextView textView1 = findViewById(R.id.h1_count);
        textView1.setText(line1);

        TextView textView2 = findViewById(R.id.description_count);
        textView2.setText(line2);

        TextView textView3 = findViewById(R.id.work_time_count);
        textView3.setText(line3);
    }

    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;

        // Add a marker in Sydney and move the camera
        LatLng sydney = new LatLng(-34, 151);
        mMap.addMarker(new MarkerOptions().position(sydney).title("Marker in Sydney"));
        mMap.moveCamera(CameraUpdateFactory.newLatLng(sydney));
        CameraPosition googlePlesk = CameraPosition.builder()
                .target(sydney)
                .zoom(9)
                .bearing(0)
                .tilt(45)
                .build();

        mMap.animateCamera(CameraUpdateFactory.newCameraPosition(googlePlesk), 2000, null);
    }
}

package com.example.myfirstapp;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.NavigationView;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import com.example.myfirstapp.Fragments.EqlFragment;
import com.example.myfirstapp.Fragments.HomeFragment;
import com.example.myfirstapp.Fragments.MapFragment;
import com.example.myfirstapp.Fragments.TimeFragment;
import com.example.myfirstapp.Menu.CreatorsActivity;
import com.example.myfirstapp.Menu.ProfileActivity;
import com.example.myfirstapp.Menu.SettingActivity;


public class MainActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        NavigationView navigationView = findViewById(R.id.nav_view);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();
        navigationView.setNavigationItemSelectedListener(this);

    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)
    {
        switch (item.getItemId())
        {
            case R.id.action_profile:
                Intent ProfileIntent = new Intent(MainActivity.this, ProfileActivity.class);
                startActivity(ProfileIntent);
                return false;


            case R.id.action_settings:
                Intent SettingIntent = new Intent(MainActivity.this, SettingActivity.class);
                startActivity(SettingIntent);
                return false;

            case R.id.action_creators:
                Intent CreatorsIntent = new Intent(MainActivity.this, CreatorsActivity.class);
                startActivity(CreatorsIntent);
                return false;
        }

        return super.onOptionsItemSelected(item);
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.nav_home) {
            setTitle("ShariX");
            HomeFragment fragment = new HomeFragment();
            FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
            fragmentTransaction.replace(R.id.fram, fragment, "Home");
            fragmentTransaction.addToBackStack("Home");
            fragmentTransaction.commit();


        } else if (id == R.id.nav_eql) {
            setTitle("Equipment list");
            EqlFragment fragment = new EqlFragment();
            FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
            fragmentTransaction.replace(R.id.fram, fragment, "Equipment list");
            fragmentTransaction.addToBackStack("Equipment list");
            fragmentTransaction.commit();

        } else if (id == R.id.nav_map) {
            setTitle("Map");
            MapFragment fragment = new MapFragment();
            FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
            fragmentTransaction.replace(R.id.fram, fragment, "Map");
            fragmentTransaction.addToBackStack("Map");
            fragmentTransaction.commit();

        } else if (id == R.id.nav_timeL) {
            setTitle("Timeline");
            TimeFragment fragment = new TimeFragment();
            FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
            fragmentTransaction.replace(R.id.fram, fragment, "Timeline");
            fragmentTransaction.addToBackStack("Timeline");
            fragmentTransaction.commit();
        }

        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;

    }
}

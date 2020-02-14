package com.example.library1.ui.library;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;

import androidx.annotation.Nullable;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.library1.Description;
import com.example.library1.R;
import com.example.library1.ui.library.data.ExampleAdapter;
import com.example.library1.ui.library.data.ExampleItem;

import java.util.ArrayList;

public class LibraryFragment extends Fragment {

    private LibraryViewModel libraryViewModel;
    RecyclerView mRecyclerView;
    RecyclerView.LayoutManager mLayoutManager;
    ExampleAdapter mAdapter;
    ArrayList<ExampleItem> exampleList;
    EditText search;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        libraryViewModel =
                ViewModelProviders.of(this).get(LibraryViewModel.class);
        View root = inflater.inflate(R.layout.fragment_library, container, false);
        // Search
        search = root.findViewById(R.id.search);
        search.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                filter(s.toString());
            }
        });
        exampleList = new ArrayList<>();
        exampleList.add(new ExampleItem(R.drawable.ic_books_24dp, "1", "10:00 - 21:00", "пр-кт Ленина, д 26, кв 58"));
        exampleList.add(new ExampleItem(R.drawable.ic_books_24dp, "2", "8:00 - 19:00", "ул Сталеваров, д 6, кв 61"));
        exampleList.add(new ExampleItem(R.drawable.ic_books_24dp, "3", "8:00 - 19:00", "ул Сталеваров, д 6, кв 61"));
        exampleList.add(new ExampleItem(R.drawable.ic_books_24dp, "3", "8:00 - 19:00", "ул Сталеваров, д 6, кв 61"));
        exampleList.add(new ExampleItem(R.drawable.ic_books_24dp, "3", "8:00 - 19:00", "ул Сталеваров, д 6, кв 61"));
        exampleList.add(new ExampleItem(R.drawable.ic_books_24dp, "3", "8:00 - 19:00", "ул Сталеваров, д 6, кв 61"));


        mRecyclerView = root.findViewById(R.id.recyclerView);
        mRecyclerView.setHasFixedSize(true);
        mLayoutManager = new LinearLayoutManager(getActivity());
        mAdapter = new ExampleAdapter(exampleList);

        mRecyclerView.setLayoutManager(mLayoutManager);
        mRecyclerView.setAdapter(mAdapter);

        mAdapter.setOnItemClickListener(new ExampleAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(int position) {
                Intent intent = new Intent(getActivity(), Description.class);
                intent.putExtra("Example Item", exampleList.get(position));

                startActivity(intent);
            }
        });

        libraryViewModel.getText().observe(this, new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {

            }
        });
        return root;
    }

    private void filter(String text) {
        ArrayList<ExampleItem> filtered = new ArrayList<>();

        for (ExampleItem item : exampleList) {
            if (item.getText1().toLowerCase().contains(text.toLowerCase())){
                filtered.add(item);
            }
        }
        mAdapter.filtered(filtered);
    }
}
<script>
  import Helper from './Helpers.svelte';

  export let name = 'world';

  let count = 0;
  $: doubled = count * 2;

  function handleClick() {
    count += 1;
  }
</script>

<Helper label={name} />
<button on:click={handleClick}>Count: {count} (doubled: {doubled})</button>
